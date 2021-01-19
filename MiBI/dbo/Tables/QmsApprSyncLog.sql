CREATE TABLE [dbo].[QmsApprSyncLog] (
    [CreatedDate]   DATETIME      CONSTRAINT [DF_QmsApprSyncLog_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [Type]          VARCHAR (50)  NULL,
    [BsId]          VARCHAR (50)  NULL,
    [sessionId]     VARCHAR (100) NULL,
    [OpptyId]       VARCHAR (100) NULL,
    [QuoteNum]      VARCHAR (50)  NULL,
    [ShoreTerr]     VARCHAR (100) NULL,
    [AsmEmail]      VARCHAR (255) NULL,
    [AsmBmLogin]    VARCHAR (255) NULL,
    [RvpEmail]      VARCHAR (255) NULL,
    [RvpBmLogin]    VARCHAR (255) NULL,
    [RdEmail]       VARCHAR (255) NULL,
    [RdBmLogin]     VARCHAR (255) NULL,
    [RegionVPEmail] VARCHAR (255) NULL,
    [RegionVPLogin] VARCHAR (255) NULL,
    [Status]        CHAR (1)      NULL,
    [Msg]           TEXT          NULL,
    CONSTRAINT [PK_QmsApprSyncLog_LOG] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 90)
);

