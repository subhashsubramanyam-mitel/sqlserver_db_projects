CREATE TABLE [support].[Chat_Details] (
    [CaseNumber]                  VARCHAR (20)   NULL,
    [Score]                       DECIMAL (5, 2) NULL,
    [Magnitude]                   DECIMAL (5, 2) NULL,
    [Emotion]                     VARCHAR (50)   NULL,
    [Owner]                       VARCHAR (100)  NULL,
    [Email]                       VARCHAR (150)  NULL,
    [TransactionDate]             DATETIME       NULL,
    [StartTime]                   DATETIME       NULL,
    [EndTime]                     DATETIME       NULL,
    [ChatDuration]                INT            NULL,
    [TranscriptId]                VARCHAR (20)   NULL,
    [AverageResponseTimeOperator] INT            NULL,
    [AverageResponseTimeVisitor]  INT            NULL,
    [OperatorMessageCount]        INT            NULL,
    [VisitorMessageCount]         INT            NULL,
    [WaitTime]                    INT            NULL,
    [Role]                        VARCHAR (100)  NULL,
    [AgentScore]                  DECIMAL (5, 2) NULL,
    [CustomerScore]               DECIMAL (5, 2) NULL,
    [Agent]                       VARCHAR (100)  NULL
);

