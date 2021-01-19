CREATE TABLE [dbo].[CaseComment] (
    [CaseCommentId]          VARCHAR (18)   NOT NULL,
    [CaseId]                 VARCHAR (50)   NULL,
    [CreatedById]            VARCHAR (50)   NULL,
    [CreatedDate]            DATETIME       NULL,
    [IsDeleted]              BIT            NULL,
    [IsNotificationSelected] BIT            NULL,
    [IsPublished]            BIT            NULL,
    [LastModifiedById]       VARCHAR (50)   NULL,
    [LastModifiedDate]       DATETIME       NULL,
    [CommentSentiment]       DECIMAL (5, 2) NULL,
    [CommentMagnitude]       DECIMAL (5, 2) NULL,
    [CommentEmotion]         VARCHAR (50)   NULL,
    [MicsPositive]           DECIMAL (5, 2) NULL,
    [MicsNegative]           DECIMAL (5, 2) NULL,
    [MicsNeutral]            DECIMAL (5, 2) NULL,
    [MicsMax]                DECIMAL (5, 2) NULL,
    [MicsEmotion]            VARCHAR (20)   NULL,
    [LastModifiedSentiment]  DATETIME       NULL,
    CONSTRAINT [PK_CaseComment] PRIMARY KEY CLUSTERED ([CaseCommentId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseComment_CaseId]
    ON [dbo].[CaseComment]([CaseId] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseComment_IsPublished]
    ON [dbo].[CaseComment]([IsPublished] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseComment_CreatedDate]
    ON [dbo].[CaseComment]([CreatedDate] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[CaseComment] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[CaseComment] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CaseComment] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[CaseComment] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[CaseComment] TO [TACECC]
    AS [dbo];

