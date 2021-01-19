CREATE TABLE [dbo].[SyncLog] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [SyncTime] DATETIME2 (7) NOT NULL,
    [LogTime]  DATETIME2 (7) CONSTRAINT [DF_SyncLog_LogTime] DEFAULT (getutcdate()) NOT NULL,
    [User]     NVARCHAR (50) CONSTRAINT [DF_SyncLog_User] DEFAULT (suser_sname()) NOT NULL,
    CONSTRAINT [PK_SyncLog] PRIMARY KEY CLUSTERED ([Id] ASC)
);

