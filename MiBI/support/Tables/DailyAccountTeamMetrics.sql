CREATE TABLE [support].[DailyAccountTeamMetrics] (
    [ID]              INT            IDENTITY (1, 1) NOT NULL,
    [Date]            DATETIME       NULL,
    [Sentiment]       DECIMAL (5, 2) NULL,
    [SLA]             DECIMAL (5, 2) NULL,
    [CaseAge]         DECIMAL (5, 2) NULL,
    [FCR]             DECIMAL (5, 2) NULL,
    [CSAT]            DECIMAL (5, 2) NULL,
    [AccountTeam]     VARCHAR (250)  NULL,
    [TransactionType] VARCHAR (50)   NULL
);

