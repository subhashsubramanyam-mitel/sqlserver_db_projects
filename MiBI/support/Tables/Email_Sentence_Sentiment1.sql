CREATE TABLE [support].[Email_Sentence_Sentiment1] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [CaseNumber]    VARCHAR (50)   NULL,
    [EmailId]       VARCHAR (50)   NULL,
    [SentenceIndex] INT            NULL,
    [Score]         DECIMAL (5, 2) NULL,
    [Sentence]      NVARCHAR (MAX) NULL,
    [Emotion]       VARCHAR (50)   NULL
);

