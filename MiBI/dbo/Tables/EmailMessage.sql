CREATE TABLE [dbo].[EmailMessage] (
    [EmailMessageId]        VARCHAR (18)    NOT NULL,
    [CaseId]                VARCHAR (50)    NULL,
    [Status]                NVARCHAR (50)   NULL,
    [MessageDate]           DATETIME        NULL,
    [FromName]              NVARCHAR (2000) NULL,
    [FromAddress]           NVARCHAR (2000) NULL,
    [ToAddress]             NVARCHAR (4000) NULL,
    [CCAddress]             VARCHAR (4000)  NULL,
    [Subject]               VARCHAR (3000)  NULL,
    [HasAttachment]         BIT             NULL,
    [IsIncoming]            BIT             NULL,
    [IsBounced]             BIT             NULL,
    [IsClientManaged]       BIT             NULL,
    [IsDeleted]             BIT             NULL,
    [IsExternallyVisible]   BIT             NULL,
    [IsOpened]              BIT             NULL,
    [IsPrivateDraft]        BIT             NULL,
    [IsTracked]             BIT             NULL,
    [CreatedById]           VARCHAR (50)    NULL,
    [CreatedDate]           DATETIME        NULL,
    [LastModifiedById]      VARCHAR (50)    NULL,
    [LastModifiedDate]      DATETIME        NULL,
    [EmailSentiment]        DECIMAL (5, 2)  NULL,
    [EmailMagnitude]        DECIMAL (5, 2)  NULL,
    [EmailEmotion]          VARCHAR (50)    NULL,
    [MicsPositive]          DECIMAL (5, 2)  NULL,
    [MicsNegative]          DECIMAL (5, 2)  NULL,
    [MicsNeutral]           DECIMAL (5, 2)  NULL,
    [MicsMax]               DECIMAL (5, 2)  NULL,
    [MicsEmotion]           VARCHAR (20)    NULL,
    [LastModifiedSentiment] DATETIME        NULL,
    CONSTRAINT [PK_EmailMessage] PRIMARY KEY CLUSTERED ([EmailMessageId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_EmailMessage_CaseId]
    ON [dbo].[EmailMessage]([CaseId] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_EmailMessage_IsIncoming]
    ON [dbo].[EmailMessage]([IsIncoming] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_EmailMessage_CreatedDate]
    ON [dbo].[EmailMessage]([CreatedDate] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[EmailMessage] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[EmailMessage] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EmailMessage] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[EmailMessage] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[EmailMessage] TO [TACECC]
    AS [dbo];

