

-- ================================================================================================================================
-- Author:		Tarak Goradia
-- Create date: 2013-03-26
-- Description:	Wrapper around dimension sync SPs
--
-- Change Log:  2015-09-09 call to optimized sync procs for ServiceProduct and TN
--				2015-11-24 sync of AccountContract
--              2019-07-23 sync of Sales Contract Lineitems
--              2020-01-25 Tarak, call to materliaze views for better sync performance
--				2020-06-04 Subhash, included oss.UspSyncServiceSettings as per Mark in Line 138
--				2020-07-09 Subhash, included enum.UspSyncContractBusinessTermVersion as per Mark in Line 134
--				2020-08-10	Subhash,included company.UspSyncM5dbCircuitCircuit as per Mark in line 123
-- ================================================================================================================================

CREATE PROCEDURE [dbo].[UspSync] 
	-- Set to a different value to trigger a sync from that time
	@lastSync datetime = NULL 
AS
BEGIN
    -- Declare general variables
    DECLARE @StartScript    datetime2;
    DECLARE @StartStep      datetime2;
    
    DECLARE @ProcName       sysname    = OBJECT_NAME(@@PROCID);
    DECLARE @RunId          int;
    DECLARE @TableName      sysname    = NULL;
    DECLARE @OperationCode  varchar(1) = NULL;
    DECLARE @RowsAffected   int        = NULL;
    DECLARE @LogMessage     varchar(1000);

    DECLARE @lastRecordVersion  binary(8) = NULL;   -- added on 2013-07-15

    DECLARE @sql            nvarchar(1000);  -- 2013-12-20
    DECLARE @parmDef        nvarchar(500);   -- 2013-12-20

	DECLARE @SafeLastSync	datetime = NULL ; -- 2015-12-08

    -- ====================================================================================================================================

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- ====================================================================================================================================

    -- Audit
    SET @StartScript = GETDATE();
    SET @LogMessage = 'Procedure has started';
        
    -- Retrieve the maximum RunId for this proc and increment by 1
    SELECT @RunId = COALESCE(MAX(RunId), 0) + 1
    FROM [dbo].[SyncAuditLog]
    WHERE ProcName = @ProcName;

    EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

	PRINT convert(varchar,getdate(),14) + N': Begin fetching call leg data';

    -- ====================================================================================================================================
 
    -- Set
    SET @StartStep = GETDATE();

	-- Start the sync from the timestamp of the last one, 
	-- unless told otherwise
	IF ( @lastSync IS NULL )
		SELECT @lastSync = DateAdd(day, -1, max( SyncTime )) FROM dbo.SyncLog; -- 8/2/2015 one extra day
	IF ( @lastSync IS NULL ) -- Can only happen for the very first time
		SET @lastSync = '1/2/1970';

	--SET @SafeLastSync = DATEADD(day, -1, @lastSync); -- 2015-12-08
	--  MW 01222020  Setting this to one day instead of 3 to get around issue with remote procedure
	--  Tarak 2020-01-20 reverting to 3 days for accuracy (not all date modified of dependent structures are captured)
	   SET @SafeLastSync = DATEADD(day, -3, @lastSync); -- 2015-12-08

    -- Log a message
    SET @LogMessage = '@lastSync = ' + CONVERT(varchar, @lastSync, 121);
    EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

    -- ====================================================================================================================================

	-- Remember when we started. If finished, this would be
	-- the cut-off time for the next sync
	DECLARE @syncTime datetime;
	SET @syncTime = getutcdate();
	
	PRINT N'Syncing changes after ' + convert(varchar,@syncTime,14);
	PRINT N'Sync start (local time): ' + convert(varchar,getdate(),14);

    -- ====================================================================================================================================

	BEGIN TRY		

    
    		-- Call the syncing stored procedures in order
            -- Set
            SET @StartStep = GETDATE();
            SET @TableName = NULL;
            SET @OperationCode = 'E';
    
            -- Log a message
            SET @LogMessage = 'About to execute stored procedures for all dimension tables';
            EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
    		-- Dimension tables (sync changes only, for those that change)
    		EXEC enum.UspSyncCluster @lastSync
    		EXEC company.UspSyncAccountAttr @lastSync
    		EXEC company.UspSyncAccount @lastSync
    		EXEC company.UspSyncAccountCluster @lastSync
    		EXEC company.UspSyncInvoiceGroup @lastSync
    		EXEC company.UspSyncLocationAttr @lastSync
    		EXEC company.UspSyncLocation @lastSync
    		EXEC company.UspSyncPartner @lastSync
			EXEC company.UspsyncAccountContract @SafelastSync -- 2015-12-08
			EXEC company.UspSyncM5dbCircuitCircuit @lastSync

			EXEC sales.UspSyncContract @SafeLastSync
			EXEC sales.UspSyncContractLineItem @SafeLastSync -- 2019-07-23

    		EXEC provision.UspSyncTnNEW @SafeLastSync -- 2015-09-09, 2015-12-08
    		EXEC provision.UspSyncProfile @lastSync, @RunId;    --<< 2013-07-15   Added second parameter: @RunId
    		EXEC people.UspSyncPerson @lastSync
    		EXEC enum.UspSyncAccessRole @lastSync
    		
    		EXEC people.UspSyncAccessRoleMember @lastSync
    
    		EXEC enum.UspSyncServiceclass @lastSync
    		EXEC enum.UspSyncProduct @lastSync
			EXEC enum.UspSyncContractBusinessTermVersion -- no parameter, Added by SS, 2020-07-09
    		
			EXEC M5DB.Billing.dbo.UspMaterializeViews -- 2020-01-25 for Better Perforamnce of syncs
    		
    		--EXEC oss.UspSyncNPS  -- stopped per Mark Woolever on 2019-05-20
    		-- The followig  may have to be separated
    		EXEC oss.UspSyncOrderNEW @SafeLastSync -- 2015-12-08
    		EXEC oss.UspSyncOrderItemNEW @lastSync  
			EXEC oss.UspSyncServiceProductNEW  @SafeLastSync ---- 2015-09-09, 2015-12-08
			EXEC oss.UspSyncOrderItemService @lastSync	-- AFTER services are synced 
			EXEC oss.UspUpdateServiceBillingAttributes  @lastSync -- 
			
			EXEC [oss].[UspSyncServiceSettings] -- no parameter, Added by SS, 2020-12-01
			EXEC oss.UspSyncServiceParentProfile -- no parameter, Added by SS, 2020-12-08

			-- Update Ac/Loc Attributes
			EXEC company.UspUpdateAccountNumPendingProfiles
			EXEC company.UspUpdateLocationNumPendingProfiles
			EXEC company.[UspUpdateAccountAttributes]

			-- Materialize OrderItemDetail View
			IF EXISTS (SELECT 1 
					   FROM INFORMATION_SCHEMA.TABLES 
					   WHERE TABLE_TYPE='BASE TABLE' 
					   AND TABLE_NAME='MatVwOrderItemDetail_Ex_Base') 
				drop  table oss.MatVwOrderItemDetail_Ex_Base;
			select *
			into oss.MatVwOrderItemDetail_Ex_Base
			from oss.VwOrderItemDetail_Ex_Base;
 
			-- Materialize ServiceProduct
			truncate table oss.MatVwServiceProduct_EX_2_Base;
			insert into oss.MatVwServiceProduct_EX_2_Base
			select * from oss.VwServiceProduct_EX_2_Base
      
            -- Log a message
            SET @LogMessage = 'sync has been completed';
            EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    
            -- ====================================================================================================================================
    
  
            -- Set
            SET @StartStep = GETDATE();
            SET @TableName = 'SyncAudit';
            SET @OperationCode = 'I';
    
    		-- Query the results of the table variable.
    		INSERT SyncAudit
    		SELECT  
    			TableName, 
    			SUM( Inserts ) AS Inserts,
    			SUM( Updates ) AS Updates,
    			SUM( Deletes ) AS Deletes,
    			@syncTime AS SyncTime
    		FROM (
    			SELECT 
    				TableName, 
    				SUM( CASE [Action] WHEN 'INSERT' THEN 1 ELSE 0 END ) AS Inserts,
    				SUM( CASE [Action] WHEN 'UPDATE' THEN 1 ELSE 0 END ) AS Updates,
    				SUM( CASE [Action] WHEN 'DELETE' THEN 1 ELSE 0 END ) AS Deletes
    			FROM SyncChanges
    			GROUP BY TableName, [Action]
    		) SA
    		GROUP BY SA.TableName
    		ORDER BY SA.TableName
    
            -- Save the row count
            SET @RowsAffected = @@ROWCOUNT;
    
     
                -- ====================================================================================================================================
    
            -- Set
            SET @StartStep = GETDATE();
            SET @TableName = 'SyncLog';
            SET @OperationCode = 'I';
    
    		-- Record the last sync time
    		INSERT [dbo].[SyncLog] ( SyncTime ) VALUES ( @syncTime )
               
            -- Save the row count, then log a message
            SET @RowsAffected = @@ROWCOUNT;
            SET @LogMessage = 'Insert has completed; SyncTime = ' + CONVERT(varchar, @syncTime, 121);
            EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;
    		
            -- ====================================================================================================================================
    
            -- Set
            SET @StartStep = GETDATE();
            SET @TableName = 'SyncChanges';
            SET @OperationCode = 'T';
            
    		-- Clear the changes table (cleanup)
    		TRUNCATE TABLE SyncChanges;
    
            -- Log a message
            SET @LogMessage = 'Table SyncChanges has been truncated';
            EXEC [dbo].[UspInsertSyncAuditLog] @StartStep, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

        -- ====================================================================================================================================

 
        -- Now we are done - log a message.
    
        -- Set
        SET @TableName = NULL;
        SET @OperationCode = NULL;
        SET @RowsAffected = NULL;
        SET @LogMessage = 'Procedure has ended';
        EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

		PRINT N'Sync end (success): ' + convert(varchar,getdate(),14);
		
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage  NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState    INT;
		DECLARE @ErrorNumber   INT;
		DECLARE @ErrorLine     INT;

		SELECT @ErrorMessage  = ERROR_MESSAGE(),
			   @ErrorSeverity = ERROR_SEVERITY(),
			   @ErrorState    = ERROR_STATE(),
			   @ErrorNumber   = ERROR_NUMBER(),
			   @ErrorLine     = ERROR_LINE();

		-- Use RAISERROR inside the CATCH block to return 
		-- error information about the original error that 
		-- caused execution to jump to the CATCH block.
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   --)
			   );
--			   ) WITH LOG;

        -- Set the error message
        SET @LogMessage = dbo.UfnFormatErrorMessage(@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorLine, @ErrorMessage);
       
        -- Now log the error
        SET @RowsAffected = NULL;
        EXEC [dbo].[UspInsertSyncAuditLog] @StartScript, @ProcName, @RunId, @TableName, @OperationCode, @RowsAffected, @LogMessage;

		PRINT N'Sync end (failure): ' + convert(varchar,getdate(),14);
		PRINT N'Error info in Windows Event Log';
		
	END CATCH;

END
