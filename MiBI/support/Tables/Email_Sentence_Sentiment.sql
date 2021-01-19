CREATE TABLE [support].[Email_Sentence_Sentiment] (
    [CaseNumber]    VARCHAR (50)   NULL,
    [CommentId]     VARCHAR (50)   NULL,
    [SentenceIndex] INT            NULL,
    [Score]         DECIMAL (5, 2) NULL,
    [Emotion]       VARCHAR (30)   NULL,
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [Sentence]      NVARCHAR (MAX) NULL
);

