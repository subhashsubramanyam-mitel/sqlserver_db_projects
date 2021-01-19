CREATE TABLE [support].[Email_Emotion2] (
    [CaseNumber]     VARCHAR (50)   NULL,
    [AgentName]      VARCHAR (100)  NULL,
    [Date]           DATETIME       NULL,
    [EmailSentiment] DECIMAL (5, 2) NULL,
    [EmailMagnitude] DECIMAL (5, 2) NULL,
    [EmailEmotion]   VARCHAR (30)   NULL,
    [Email]          VARCHAR (100)  NULL,
    [Role]           VARCHAR (100)  NULL,
    [CaseId]         VARCHAR (50)   NULL,
    [CommentId]      VARCHAR (50)   NULL,
    [IsPublic]       VARCHAR (20)   NULL,
    [IsCustomer]     VARCHAR (10)   NULL,
    [MICS_Positive]  DECIMAL (5, 2) NULL,
    [MICS_Negative]  DECIMAL (5, 2) NULL,
    [MICS_Neutral]   DECIMAL (5, 2) NULL,
    [MICS_Max_Score] DECIMAL (5, 2) NULL,
    [MICS_Emotion]   VARCHAR (20)   NULL
);

