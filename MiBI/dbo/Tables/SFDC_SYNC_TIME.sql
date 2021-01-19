CREATE TABLE [dbo].[SFDC_SYNC_TIME] (
    [TableName]       VARCHAR (50) NOT NULL,
    [LastSyncTimeUTC] DATETIME     NULL,
    [LastSyncTime]    DATETIME     NULL,
    CONSTRAINT [PK_SFDC_SYNC_TIME] PRIMARY KEY CLUSTERED ([TableName] ASC)
);

