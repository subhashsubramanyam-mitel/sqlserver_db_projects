CREATE TABLE [dbo].[LiveChatTranscript] (
    [LiveChatTranscriptId]        VARCHAR (18)   NOT NULL,
    [LiveChatTranscriptName]      VARCHAR (255)  NULL,
    [CaseId]                      VARCHAR (50)   NULL,
    [CreatedById]                 VARCHAR (50)   NULL,
    [CreatedDate]                 DATETIME       NULL,
    [StartTime]                   DATETIME       NULL,
    [EndTime]                     DATETIME       NULL,
    [ChatDuration]                INT            NULL,
    [OwnerId]                     VARCHAR (50)   NULL,
    [Platform]                    NVARCHAR (300) NULL,
    [EndedBy]                     VARCHAR (255)  NULL,
    [LastModifiedById]            VARCHAR (50)   NULL,
    [LastModifiedDate]            DATETIME       NULL,
    [LiveChatButtonId]            VARCHAR (18)   NULL,
    [LiveChatDeploymentId]        VARCHAR (18)   NULL,
    [LiveChatVisitorId]           VARCHAR (18)   NULL,
    [RequestTime]                 DATETIME       NULL,
    [AverageResponseTimeOperator] INT            NULL,
    [AverageResponseTimeVisitor]  INT            NULL,
    [MaxResponseTimeOperator]     INT            NULL,
    [MaxResponseTimeVisitor]      INT            NULL,
    [OperatorMessageCount]        INT            NULL,
    [VisitorMessageCount]         INT            NULL,
    [WaitTime]                    INT            NULL,
    [IsChatbotSession]            BIT            NULL,
    [IsDeleted]                   BIT            NULL,
    [Abandoned]                   INT            NULL,
    [SkillId]                     VARCHAR (18)   NULL,
    [Status]                      NVARCHAR (255) NULL,
    [UserAgent]                   NVARCHAR (300) NULL,
    [ChatScore]                   DECIMAL (5, 2) NULL,
    [ChatMagnitude]               DECIMAL (5, 2) NULL,
    [ChatEmotion]                 VARCHAR (50)   NULL,
    [MicsAgentPositive]           DECIMAL (5, 2) NULL,
    [MicsAgentNegative]           DECIMAL (5, 2) NULL,
    [MicsAgentNeutral]            DECIMAL (5, 2) NULL,
    [MicsAgentMax]                DECIMAL (5, 2) NULL,
    [MicsAgentEmotion]            VARCHAR (20)   NULL,
    [MicsCustPositive]            DECIMAL (5, 2) NULL,
    [MicsCustNegative]            DECIMAL (5, 2) NULL,
    [MicsCustNeutral]             DECIMAL (5, 2) NULL,
    [MicsCustMax]                 DECIMAL (5, 2) NULL,
    [MicsCustEmotion]             VARCHAR (20)   NULL,
    [LastModifiedSentiment]       DATETIME       NULL,
    [AgentName]                   VARCHAR (255)  NULL,
    [MicsPositive]                DECIMAL (5, 2) NULL,
    [MicsNegative]                DECIMAL (5, 2) NULL,
    [MicsNeutral]                 DECIMAL (5, 2) NULL,
    [MicsMax]                     DECIMAL (5, 2) NULL,
    [MicsEmotion]                 VARCHAR (20)   NULL,
    CONSTRAINT [PK_LiveChatTranscript] PRIMARY KEY CLUSTERED ([LiveChatTranscriptId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_LiveChatTranscript_CaseId]
    ON [dbo].[LiveChatTranscript]([CaseId] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_LiveChatTranscript_CreatedDate]
    ON [dbo].[LiveChatTranscript]([CreatedDate] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[LiveChatTranscript] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LiveChatTranscript] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LiveChatTranscript] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LiveChatTranscript] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[LiveChatTranscript] TO [TACECC]
    AS [dbo];

