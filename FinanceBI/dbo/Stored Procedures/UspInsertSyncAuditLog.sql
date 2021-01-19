-- ============================================================================================
-- Author:        Gerard Amitrano/Tarak Goradia
-- Create date:   3/8/2013
-- Description:   Inserts one row into the SyncAuditLog table
--                Calls the function UfnCalcElapsed to retrieve the formatted, elapsed time
--                between the StartTime and EndTime values.
--                The EndTime will default to the system date and time.
-- Return value:  None
-- ============================================================================================

create PROCEDURE UspInsertSyncAuditLog
  @StartTime           datetime ,
  @ProcName            sysname ,  
  @RunId               int ,  
  @TableName           sysname ,
  @OperationCode       varchar(1) ,
  @RowsAffected        int ,
  @LogMessage          varchar(1000)

AS
  BEGIN
    -- Suppress interim messages
    SET NOCOUNT ON

    -- General variables
    DECLARE @StartTimeTemp   datetime;
    DECLARE @EndTime         datetime;
    DECLARE @CalcElapsed     varchar(10);
    DECLARE @OperationName   varchar(8);
    
    -- Set the time values
    SET @EndTime = getdate();
    IF ( @StartTime IS NULL  OR  @StartTime > @EndTime )
        SET @StartTimeTemp = @EndTime;
    ELSE
        SET @StartTimeTemp = @StartTime;

    -- Set the Operation Name
    SET @OperationName = CASE @OperationCode
                             WHEN 'C' THEN 'CREATE'
                             WHEN 'D' THEN 'DELETE'
                             WHEN 'E' THEN 'EXECUTE'
                             WHEN 'I' THEN 'INSERT'
                             WHEN 'M' THEN 'MERGE'
                             WHEN 'R' THEN 'DROP'   -- D will be used for DELETE
                             WHEN 'S' THEN 'SELECT'
                             WHEN 'T' THEN 'TRUNCATE'
                             WHEN 'U' THEN 'UPDATE'
                             ELSE NULL
                         END;

    -- Calculate elapsed_time
    SET @CalcElapsed = dbo.UfnCalcElapsed(@StartTimeTemp, @EndTime);

    -- Insert into the audit log table
    -- LogId is an IDENTITY column    
    INSERT INTO SyncAuditLog
    (
      StartTime ,
      EndTime ,
      ElapsedTime ,
      ProcName ,
      RunId ,      
      TableName ,
      Operation ,
      RowsAffected ,
      LogMessage
    )
    VALUES
    (
      @StartTimeTemp ,
      @EndTime ,
      @CalcElapsed ,
      @ProcName ,
      @RunId ,      
      @TableName ,
      @OperationName ,
      @RowsAffected ,
      @LogMessage
    );
  END
