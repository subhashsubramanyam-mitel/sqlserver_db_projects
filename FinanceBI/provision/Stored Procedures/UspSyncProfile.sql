-- =======================================================================================================
-- Author:		Yaniv Schahar
-- Create date: 2011-04-08
-- Description:	Sync Profile data
--
-- Change Log:
-- 2012-08-07   Tarak, added inner join on DimLocation since some locations are not synced.
--
-- 2013-07-11   Gerry Amitrano
--              The procedure was re-written so that it now checks for Foreign Key violations prior to 
--              the MERGE operation.  Rows with at least one FK violation will not be merged into the
--              target table, but will instead be inserted into a 'violation history' table.
--              Just to be safe, it also checks for NULL values intended for NOT NULL columns.
--              The procedure now also includes audit statements, and takes one additional parameter (@RunId)
-- ========================================================================================================

create PROCEDURE provision.UspSyncProfile 

@lastSync  datetime = NULL ,
@RunId     int

 AS

  BEGIN
    -- Declare general variables
    DECLARE @StartScript    datetime2;
    DECLARE @StartStep      datetime2;
    
    DECLARE @ProcName       sysname    = OBJECT_NAME(@@PROCID);
    DECLARE @TableName      sysname    = NULL;
    DECLARE @OperationCode  varchar(1) = NULL;
    DECLARE @RowsAffected   int        = NULL;
    DECLARE @LogMessage     varchar(1000);
    
    DECLARE @RowsInserted   int;
    DECLARE @RowsUpdated    int;

    DECLARE @SyncBuffer     int = 30;  --<<< number of minutes
    
    DECLARE @tblAction TABLE
    (
      ActionCode  char(1)
    );

    -- ====================================================================================================================================
  
    -- Suppress interim messages
    SET NOCOUNT ON;

    -- ====================================================================================================================================

    BEGIN TRY
        -- Audit
        SET @StartScript = GETDATE();
        SET @LogMessage = 'Procedure has started';
    
        EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        PRINT CONVERT(varchar,getdate(),14) + ': ' + @ProcName + ' ' + @LogMessage;
    
        -- ====================================================================================================================================
    
        -- Drop the temporary table if it already exists
        IF OBJECT_ID('tempdb.dbo.#Profiles') IS NOT NULL
            DROP TABLE #Profiles;

        -- ====================================================================================================================================

        -- Set
        SET @StartStep = GETDATE();
        SET @TableName = '#Profiles';
        SET @OperationCode = 'I';

        WITH CTE AS
        (
          -- Select M5DB data that is eligible for the Merge
          -- We are using the CTE so that we are not trying to join M5DB tables directly with RPTSQL1 tables
          -- The CTE should be resolved first, then the resultset will be joined to the RPTSQL1 tables below.
          -- NOTE:  We will apply a buffer to the Last Sync time.  This will extend the time range.
          --        This is done to catch any Ids that may have failed during a previous run due to a Violation, but now
          --        will no longer have that violation.
          SELECT P.Id , 
                 L.AccountId ,
                 P.LocationId , 
                 P.ProfileTypeId ,
                 P.TimeZoneId ,
                 COALESCE(LTRIM(RTRIM(PE.FirstName + ' ' + PE.LastName)), P.InternalCallerId, P.ComponentName) AS Name ,
                 P.TnId AS Tn ,
                 P.TnCountryId AS TnCountryId ,
                 P.InternalCallerId AS [CallerId] ,
                 CASE P.ProfileStatusId WHEN 0 THEN 1 ELSE 0 END AS IsActive ,
                 P.IsDid AS [IsDid] ,
                 P.Extension

          FROM M5DB.M5DB.Dbo.Profile P WITH (NOLOCK)
              INNER JOIN M5DB.M5DB.Dbo.Location L WITH (NOLOCK)
                  ON P.LocationId = L.Id
              INNER JOIN M5DB.M5DB.Dbo.Tn T WITH (NOLOCK)
                  ON T.Id = P.TnId
                 AND T.CountryId = P.TnCountryId
              LEFT JOIN M5DB.M5DB.Dbo.[Person] PE WITH (NOLOCK)
                  ON P.PersonId = PE.Id

          WHERE P.DateModified >= DATEADD(MINUTE, -ABS(@SyncBuffer), @lastSync)  --<<< apply the buffer
        )
        -- This is the final SELECT
        -- Here, we perform LEFT JOINs for each of the Foreign Key constraints that exist on the DimProfile table
        -- We will set a flag for each FK to indicate whether there will be a violation (1=Yes)
        -- The resultset will be inserted into the temporary table (created dynamically)
        SELECT A.Id , 
               A.AccountId ,
               A.LocationId , 
               A.ProfileTypeId ,
               A.TimeZoneId ,
               A.Name ,
               A.Tn ,
               A.TnCountryId ,
               A.CallerId ,
               A.IsActive ,
               A.IsDid ,
               A.Extension ,               
               CASE WHEN A.AccountId     IS NOT NULL AND B.Id IS NULL THEN 1 ELSE 0 END AS ViolationAccount ,
               CASE WHEN A.LocationId    IS NOT NULL AND C.Id IS NULL THEN 1 ELSE 0 END AS ViolationLocation ,
               CASE WHEN A.ProfileTypeId IS NOT NULL AND D.Id IS NULL THEN 1 ELSE 0 END AS ViolationProfileType ,
               CASE WHEN A.TimeZoneId    IS NOT NULL AND E.Id IS NULL THEN 1 ELSE 0 END AS ViolationTimeZone ,
               CASE WHEN A.Tn            IS NOT NULL AND F.Id IS NULL THEN 1 ELSE 0 END AS ViolationTn ,
               -- We will also check each of the NOT NULL columns to be sure that the value will intend to use is NOT NULL
               -- We don't expect to encounter this error - just being safe
               CASE WHEN A.Id            IS NULL
                      OR A.AccountId     IS NULL
                      OR A.LocationId    IS NULL
                      OR A.ProfileTypeId IS NULL
                      OR A.TnCountryId   IS NULL
                      OR A.IsActive      IS NULL
                      OR A.IsDid         IS NULL
                    THEN 1
                    ELSE 0
               END AS ViolationNull

        INTO #Profiles

        FROM CTE A
            LEFT JOIN company.Account B
                ON A.AccountId = B.Id
            LEFT JOIN company.Location C
                ON A.LocationId = C.Id
            LEFT JOIN enum.ProfileType D
                ON A.ProfileTypeId = D.Id
            LEFT JOIN enum.TimeZone E
                ON A.TimeZoneId = E.Id
            LEFT JOIN provision.Tn F
                ON A.Tn = F.Id
               AND A.TnCountryId = F.CountryId;
            
        -- Save the row count, then log a message
        SET @RowsAffected = @@ROWCOUNT;
        SET @LogMessage = 'Insert into ' + @TableName + ' has completed';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage;

        -- ====================================================================================================================================
   
        -- Set
        SET @StartStep = GETDATE();
        SET @TableName = 'DimProfile';
        SET @OperationCode = 'M';

        -- Merge the temporary table data into the target table
        MERGE INTO provision.Profile A
            USING (
                    SELECT *
                    FROM #Profiles
                    WHERE ViolationAccount + ViolationLocation + ViolationProfileType + ViolationTimeZone + ViolationTn = 0  -- no FK violations
                      AND ViolationNull = 0  -- all NOT NULL columns will have a non-NULL value
                  ) B
                ON A.Id = B.Id
        WHEN MATCHED 
         AND (
               -- At least one column must actually be updated with a different value
               -- First check the NOT NULL columns               
               ( A.AccountId      <> B.AccountId  )
               OR
               ( A.LocationId     <> B.LocationId )
               OR
               ( A.ProfileTypeId  <> B.ProfileTypeId )
               OR
               ( A.TnCountryId    <> B.TnCountryId )
               OR
               ( A.IsActive       <> B.IsActive )
               OR
               ( A.IsDid          <> B.IsDid )
               -- Now check the Nullable columns                              
               OR
               ( ( A.TimeZoneId   <> B.TimeZoneId ) OR ( A.TimeZoneId IS NOT NULL AND B.TimeZoneId IS NULL ) OR ( A.TimeZoneId IS NULL AND B.TimeZoneId IS NOT NULL ) )
               OR
               ( ( A.Name         <> B.Name       ) OR ( A.Name       IS NOT NULL AND B.Name       IS NULL ) OR ( A.Name       IS NULL AND B.Name       IS NOT NULL ) )
               OR
               ( ( A.Tn           <> B.Tn         ) OR ( A.Tn         IS NOT NULL AND B.Tn         IS NULL ) OR ( A.Tn         IS NULL AND B.Tn         IS NOT NULL ) )
               OR
               ( ( A.CallerId     <> B.CallerId   ) OR ( A.CallerId   IS NOT NULL AND B.CallerId   IS NULL ) OR ( A.CallerId   IS NULL AND B.CallerId   IS NOT NULL ) )
               OR
               ( ( A.Extension    <> B.Extension  ) OR ( A.Extension  IS NOT NULL AND B.Extension  IS NULL ) OR ( A.Extension  IS NULL AND B.Extension  IS NOT NULL ) )
             )
        THEN
            -- Update with the revised values
            UPDATE
            SET A.AccountId     = B.AccountId ,
                A.LocationId    = B.LocationId ,
                A.ProfileTypeId = B.ProfileTypeId ,
                A.TimeZoneId    = B.TimeZoneId ,
                A.Name          = B.Name ,
                A.Tn            = B.Tn ,
                A.TnCountryId   = B.TnCountryId ,
                A.CallerId      = B.CallerId ,
                A.IsActive      = B.IsActive ,
                A.IsDid         = B.IsDid ,
                A.Extension     = B.Extension
                
        WHEN NOT MATCHED THEN
            -- Insert a row
            INSERT
            (
              Id ,
              AccountId ,
              LocationId ,
              ProfileTypeId ,
              TimeZoneId ,
              Name ,
              Tn ,
              TnCountryId ,
              CallerId ,
              IsActive ,
              IsDid ,
              Extension
            )
            VALUES
            (
              B.Id ,
              B.AccountId ,
              B.LocationId ,
              B.ProfileTypeId ,
              B.TimeZoneId ,
              B.Name ,
              B.Tn ,
              B.TnCountryId ,
              B.CallerId ,
              B.IsActive ,
              B.IsDid ,
              B.Extension
            )
        OUTPUT
            SUBSTRING($action, 1, 1) INTO @tblAction;
           
        -- Save the row count, then log a message
        SET @RowsAffected = @@ROWCOUNT;
        SET @LogMessage = 'Merge has completed';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage;

        -- ====================================================================================================================================

        -- Set
        SET @StartStep = GETDATE();
        SET @TableName = '@tblAction';
        SET @OperationCode = 'S';
    
        -- Determine the number of INSERTs and UPDATEs that were performed via the MERGE.
        SELECT @RowsInserted = COALESCE(SUM(CASE WHEN ActionCode = 'I' THEN 1 ELSE 0 END), 0) ,
               @RowsUpdated  = COALESCE(SUM(CASE WHEN ActionCode = 'U' THEN 1 ELSE 0 END), 0)
        FROM @tblAction;
           
        -- Log a message  ( first report the @RowsInserted value )
        SET @LogMessage = 'Count of rows that had been inserted via MERGE';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsInserted, @LogMessage;

        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage + ' = ' + CONVERT(varchar, @RowsInserted);

        -- Now log a message for Updates; pass NULL for StartTime
        SET @LogMessage = 'Count of rows that had been updated via MERGE';
        EXEC [dbo].[UspInsertSyncAuditLog] NULL, @ProcName, @RunId, @TableName, @OperationCode, @RowsUpdated, @LogMessage;
    
        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage + ' = ' + CONVERT(varchar, @RowsUpdated);

        -- ====================================================================================================================================

        -- Set
        SET @StartStep = GETDATE();
        SET @TableName = 'SyncViolationsProfile';
        SET @OperationCode = 'I';
    
        -- Save those rows that have been identified with a Foreign Key violation
        INSERT INTO provision.SyncViolationsProfile
        (
          RunId ,
          DateCreated ,
          MergeOperation ,          
          Id ,
          AccountId ,          --  5
          LocationId ,
          ProfileTypeId ,
          TimeZoneId ,
          Name ,
          Tn ,                 -- 10
          TnCountryId ,
          CallerId ,
          IsActive ,
          IsDid ,
          Extension ,          -- 15
          ViolationAccount ,
          ViolationLocation ,
          ViolationProfileType ,
          ViolationTimeZone ,
          ViolationTn ,       -- 20
          ViolationNull       -- 21
        )
        SELECT @RunId AS RunId ,
               GETDATE() AS DateCreated ,
               CASE
                   WHEN B.Id IS NOT NULL THEN 'U'  -- Id exists in DimProfile; MERGE would attempt an UPDATE
                   ELSE 'I'   -- INSERT
               END AS MergeOperation ,
               A.Id ,
               A.AccountId ,         --  5
               A.LocationId ,
               A.ProfileTypeId ,
               A.TimeZoneId ,
               A.Name ,
               A.Tn ,                -- 10
               A.TnCountryId ,
               A.CallerId ,
               A.IsActive ,
               A.IsDid ,
               A.Extension ,          -- 15
               A.ViolationAccount ,
               A.ViolationLocation ,
               A.ViolationProfileType ,
               A.ViolationTimeZone ,
               A.ViolationTn ,       -- 20
               A.ViolationNull       -- 21
        FROM #Profiles A
            LEFT JOIN provision.Profile B
                ON A.Id = B.Id        
        WHERE A.ViolationAccount + A.ViolationLocation + A.ViolationProfileType + A.ViolationTimeZone + A.ViolationTn > 0  -- at least one FK violation        
           OR A.ViolationNull > 0;   -- at least one Null violation
           
        -- Save the row count, then log a message
        SET @RowsAffected = @@ROWCOUNT;
        SET @LogMessage = 'Violations have been inserted into ' + @TableName;
        IF ( @RowsAffected > 0 )
            SET @LogMessage = 'WARNING: ' + @LogMessage;
        EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage;

        -- ====================================================================================================================================

        -- Set
        SET @StartStep = GETDATE();
        SET @TableName = 'SyncChanges';
        SET @OperationCode = 'I';

        -- Insert
        INSERT INTO [dbo].[SyncChanges]
        (
          TableName ,
          Action
        )
        SELECT 'DimProfile' AS TableName ,
               ActionCode
        FROM @tblAction;                
           
        -- Save the row count, then log a message
        SET @RowsAffected = @@ROWCOUNT;
        SET @LogMessage = 'Insert into ' + @TableName + ' has completed';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        -- PRINT CONVERT(varchar,getdate(),14) + ': ' + @LogMessage;

        -- ====================================================================================================================================
    
        -- Now we are done - log a message.
    
        -- Set
        SET @TableName = NULL;
        SET @OperationCode = NULL;
        SET @RowsAffected = NULL;
        SET @LogMessage = 'Procedure has ended';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
        PRINT CONVERT(varchar,getdate(),14) + ': ' + @ProcName + ' ' + @LogMessage;
    END TRY
    BEGIN CATCH
        -- Set the error message
        SET @LogMessage = dbo.UfnFormatErrorMessage(ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_LINE(), ERROR_MESSAGE());
       
        -- Now log the error
        SET @RowsAffected = NULL;
        EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

        PRINT CONVERT(varchar,getdate(),14) + ': ' + @ProcName + ': ' + @LogMessage;

        -- We want to raise an error here to notify the caller
        RAISERROR(@LogMessage, 16, 1);
        RETURN 0;
    END CATCH;

  END
