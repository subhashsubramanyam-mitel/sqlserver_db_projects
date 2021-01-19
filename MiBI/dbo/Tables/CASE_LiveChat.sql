CREATE TABLE [dbo].[CASE_LiveChat] (
    [Created]        DATETIME       CONSTRAINT [DF_CASE_LiveChat_Created] DEFAULT (getdate()) NOT NULL,
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [ChatTxId]       NVARCHAR (255) NULL,
    [CaseId]         VARCHAR (50)   NULL,
    [AbandonedAfter] FLOAT (53)     CONSTRAINT [DF_CASE_LiveChat_AbandonedAfter] DEFAULT ((0)) NULL,
    [ChatDuration]   FLOAT (53)     CONSTRAINT [DF_CASE_LiveChat_ChatDuration] DEFAULT ((0)) NULL,
    [RequestTime]    DATETIME       NULL,
    [WaitTime]       FLOAT (53)     CONSTRAINT [DF_CASE_LiveChat_WaitTime] DEFAULT ((0)) NULL,
    [OwnerName]      NVARCHAR (255) NULL,
    [DeveloperName]  NVARCHAR (255) NULL,
    CONSTRAINT [PK_CASE_LiveChat] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[CASE_LiveChat] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[CASE_LiveChat] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CASE_LiveChat] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[CASE_LiveChat] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[CASE_LiveChat] TO [TACECC]
    AS [dbo];

