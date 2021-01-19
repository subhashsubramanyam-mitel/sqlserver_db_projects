CREATE TABLE [dbo].[SyncAuditLog] (
    [LogId]        INT            IDENTITY (1, 1) NOT NULL,
    [StartTime]    DATETIME       NULL,
    [EndTime]      DATETIME       NULL,
    [ElapsedTime]  VARCHAR (10)   NULL,
    [ProcName]     NVARCHAR (128) NULL,
    [RunId]        INT            NULL,
    [TableName]    NVARCHAR (128) NULL,
    [Operation]    VARCHAR (8)    NULL,
    [RowsAffected] INT            NULL,
    [LogMessage]   VARCHAR (1000) NULL,
    PRIMARY KEY CLUSTERED ([LogId] ASC)
);

