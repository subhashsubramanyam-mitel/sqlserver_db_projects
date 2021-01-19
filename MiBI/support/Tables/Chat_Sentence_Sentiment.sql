CREATE TABLE [support].[Chat_Sentence_Sentiment] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [CaseNumber]    VARCHAR (50)   NULL,
    [TranscriptId]  VARCHAR (50)   NULL,
    [SentenceIndex] INT            NULL,
    [Sentence]      NVARCHAR (MAX) NULL,
    [Score]         DECIMAL (5, 2) NULL,
    [Emotion]       VARCHAR (50)   NULL
);

