﻿CREATE TABLE [tmp].[MiCustomerSentiment_bkp] (
    [CaseId]                       VARCHAR (50)    NOT NULL,
    [CaseNumber]                   VARCHAR (255)   NOT NULL,
    [CreatedDate]                  DATETIME        NULL,
    [ClosedDate]                   DATETIME        NULL,
    [FCR]                          INT             NULL,
    [Status]                       VARCHAR (500)   NULL,
    [AtRisk]                       VARCHAR (500)   NULL,
    [CaseOrigin]                   VARCHAR (500)   NULL,
    [CaseOwnerRole]                VARCHAR (100)   NULL,
    [CaseOwner]                    VARCHAR (500)   NULL,
    [ATEscalation]                 VARCHAR (500)   NULL,
    [CaseReason]                   VARCHAR (500)   NULL,
    [CaseMilestone_Completed]      VARCHAR (50)    NULL,
    [CaseMilestone_Violation]      VARCHAR (50)    NULL,
    [CaseMilestone_Date]           DATETIME        NULL,
    [Surveys_PrimaryScore]         INT             NULL,
    [Surveys_DataCollectionName]   VARCHAR (200)   NULL,
    [Surveys_ResponseReceivedDate] DATETIME        NULL,
    [Surveys_Source]               VARCHAR (50)    NULL,
    [Surveys_Date]                 DATETIME        NULL,
    [CaseCommentId]                VARCHAR (18)    NULL,
    [Comment_CreatedBy]            VARCHAR (500)   NULL,
    [Comment_Date]                 DATETIME        NULL,
    [Comment_MicsPositive]         DECIMAL (5, 2)  NULL,
    [Comment_MicsNegative]         DECIMAL (5, 2)  NULL,
    [Comment_MicsNeutral]          DECIMAL (5, 2)  NULL,
    [Comment_MicsMax]              DECIMAL (5, 2)  NULL,
    [Comment_MicsEmotion]          VARCHAR (20)    NULL,
    [LiveChatTranscriptId]         VARCHAR (18)    NULL,
    [Chat_CreatedBy]               VARCHAR (500)   NULL,
    [LiveChatTranscriptName]       VARCHAR (255)   NULL,
    [ChatDate]                     DATETIME        NULL,
    [StartTime]                    DATETIME        NULL,
    [EndTime]                      DATETIME        NULL,
    [ChatDuration]                 INT             NULL,
    [ChatOwner]                    VARCHAR (50)    NULL,
    [AverageResponseTimeOperator]  INT             NULL,
    [AverageResponseTimeVisitor]   INT             NULL,
    [MaxResponseTimeOperator]      INT             NULL,
    [MaxResponseTimeVisitor]       INT             NULL,
    [OperatorMessageCount]         INT             NULL,
    [VisitorMessageCount]          INT             NULL,
    [WaitTime]                     INT             NULL,
    [Abandoned]                    INT             NULL,
    [Chat_MicsAgentPositive]       DECIMAL (5, 2)  NULL,
    [Chat_MicsAgentNegative]       DECIMAL (5, 2)  NULL,
    [Chat_MicsAgentNeutral]        DECIMAL (5, 2)  NULL,
    [Chat_MicsAgentMax]            DECIMAL (5, 2)  NULL,
    [Chat_MicsAgentEmotion]        VARCHAR (20)    NULL,
    [Chat_MicsCustPositive]        DECIMAL (5, 2)  NULL,
    [Chat_MicsCustNegative]        DECIMAL (5, 2)  NULL,
    [Chat_MicsCustNeutral]         DECIMAL (5, 2)  NULL,
    [Chat_MicsCustMax]             DECIMAL (5, 2)  NULL,
    [Chat_MicsCustEmotion]         VARCHAR (20)    NULL,
    [Chat_MicsPositive]            DECIMAL (5, 2)  NULL,
    [Chat_MicsNegative]            DECIMAL (5, 2)  NULL,
    [Chat_MicsNeutral]             DECIMAL (5, 2)  NULL,
    [Chat_MicsMax]                 DECIMAL (5, 2)  NULL,
    [Chat_MicsEmotion]             VARCHAR (20)    NULL,
    [EmailMessageId]               VARCHAR (18)    NULL,
    [Email_CreatedBy]              VARCHAR (500)   NULL,
    [Email_Status]                 NVARCHAR (50)   NULL,
    [Email_Date]                   DATETIME        NULL,
    [FromName]                     NVARCHAR (2000) NULL,
    [FromAddress]                  NVARCHAR (2000) NULL,
    [ToAddress]                    NVARCHAR (4000) NULL,
    [CCAddress]                    VARCHAR (4000)  NULL,
    [Email_Subject]                VARCHAR (3000)  NULL,
    [Email_MicsPositive]           DECIMAL (5, 2)  NULL,
    [Email_MicsNegative]           DECIMAL (5, 2)  NULL,
    [Email_MicsNeutral]            DECIMAL (5, 2)  NULL,
    [Email_MicsMax]                DECIMAL (5, 2)  NULL,
    [Email_MicsEmotion]            VARCHAR (20)    NULL
);

