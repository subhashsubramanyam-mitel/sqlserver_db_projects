CREATE TABLE [tmp].[Sentiment_Analytics1] (
    [CallRecording]     VARCHAR (50)   NOT NULL,
    [CaseNumber]        VARCHAR (10)   NULL,
    [CustomerType]      VARCHAR (10)   NULL,
    [CaseReason]        VARCHAR (30)   NULL,
    [SubReason]         VARCHAR (30)   NULL,
    [AgentId]           INT            NULL,
    [AgentName]         VARCHAR (20)   NULL,
    [Extension]         VARCHAR (10)   NULL,
    [InteractionTime]   VARCHAR (10)   NULL,
    [IdleTime]          VARCHAR (10)   NULL,
    [CustomerSentiment] DECIMAL (5, 2) NULL,
    [Magnitude]         DECIMAL (5, 2) NULL,
    [Emotion]           VARCHAR (10)   NULL,
    [CSATScore]         DECIMAL (5, 2) NULL,
    [FCR]               DECIMAL (5, 2) NULL,
    [CaseAge]           DECIMAL (5, 2) NULL,
    [SLA]               DECIMAL (5, 2) NULL
);

