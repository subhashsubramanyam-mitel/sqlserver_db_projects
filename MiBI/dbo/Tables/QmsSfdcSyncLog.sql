CREATE TABLE [dbo].[QmsSfdcSyncLog] (
    [CreatedDate] DATETIME     CONSTRAINT [DF_QmsSfdcSyncLog_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [UpdateType]  VARCHAR (50) NULL,
    [BM_Id]       VARCHAR (50) NULL,
    [BM_Table]    VARCHAR (50) NULL,
    [PromotionId] VARCHAR (50) NULL,
    [ContractId]  VARCHAR (50) NULL,
    [Msg]         TEXT         NULL,
    CONSTRAINT [PK_QmsSfdcSyncLog_LOG] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 90)
);

