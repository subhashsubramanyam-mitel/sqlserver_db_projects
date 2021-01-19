CREATE TABLE [dbo].[SyncAudit] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [TableName] VARCHAR (100) NOT NULL,
    [Inserts]   INT           NOT NULL,
    [Updates]   INT           NOT NULL,
    [Deletes]   INT           NOT NULL,
    [SyncTime]  DATETIME2 (7) CONSTRAINT [DF_SyncAudit_SyncTime] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_SyncAudit] PRIMARY KEY CLUSTERED ([Id] ASC)
);

