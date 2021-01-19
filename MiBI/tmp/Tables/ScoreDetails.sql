CREATE TABLE [tmp].[ScoreDetails] (
    [PrimaryId]     INT             IDENTITY (1, 1) NOT NULL,
    [CallRecording] VARCHAR (250)   NULL,
    [Id]            INT             NOT NULL,
    [SentenceScore] DECIMAL (5, 2)  NULL,
    [Sentence]      NVARCHAR (1024) NULL,
    PRIMARY KEY CLUSTERED ([PrimaryId] ASC)
);

