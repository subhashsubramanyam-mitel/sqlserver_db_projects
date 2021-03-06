﻿CREATE TABLE [BlueT].[LiveChatTranscript] (
    [Id]                          VARCHAR (20)  NOT NULL,
    [Abandoned]                   INT           NULL,
    [AccountId]                   VARCHAR (20)  NULL,
    [AverageResponseTimeOperator] INT           NULL,
    [AverageResponseTimeVisitor]  INT           NULL,
    [CaseId]                      VARCHAR (20)  NULL,
    [Case_Number__c]              VARCHAR (255) NULL,
    [ChatDuration]                INT           NULL,
    [ChatKey]                     VARCHAR (200) NULL,
    [ContactId]                   VARCHAR (20)  NULL,
    [Contact__c]                  VARCHAR (20)  NULL,
    [CreatedById]                 VARCHAR (20)  NULL,
    [CreatedDate]                 DATETIME      NULL,
    [EndedBy]                     VARCHAR (255) NULL,
    [EndTime]                     DATETIME      NULL,
    [IsChatbotSession]            BIT           NULL,
    [IsDeleted]                   BIT           NULL,
    [LastModifiedById]            VARCHAR (20)  NULL,
    [LastModifiedDate]            DATETIME      NULL,
    [LastReferencedDate]          DATETIME      NULL,
    [LastViewedDate]              DATETIME      NULL,
    [LeadId]                      VARCHAR (20)  NULL,
    [LiveChatButtonId]            VARCHAR (20)  NULL,
    [LiveChatDeploymentId]        VARCHAR (20)  NULL,
    [LiveChatVisitorId]           VARCHAR (20)  NULL,
    [Location]                    VARCHAR (200) NULL,
    [MaxResponseTimeOperator]     INT           NULL,
    [MaxResponseTimeVisitor]      INT           NULL,
    [Name]                        VARCHAR (255) NULL,
    [OperatorMessageCount]        INT           NULL,
    [OwnerId]                     VARCHAR (20)  NULL,
    [RequestTime]                 DATETIME      NULL,
    [Service_ContactId__c]        VARCHAR (200) NULL,
    [Service_Description__c]      VARCHAR (255) NULL,
    [Service_Email_Address__c]    VARCHAR (255) NULL,
    [Service_Feature__c]          VARCHAR (255) NULL,
    [Service_First_Name__c]       VARCHAR (255) NULL,
    [Service_Last_Name__c]        VARCHAR (255) NULL,
    [SkillId]                     VARCHAR (20)  NULL,
    [StartTime]                   DATETIME      NULL,
    [Status]                      VARCHAR (255) NULL,
    [VisitorMessageCount]         INT           NULL,
    [WaitTime]                    INT           NULL,
    CONSTRAINT [PK_blue_LiveChatTranscript] PRIMARY KEY CLUSTERED ([Id] ASC)
);

