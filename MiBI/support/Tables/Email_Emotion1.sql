﻿CREATE TABLE [support].[Email_Emotion1] (
    [CaseNumber]      VARCHAR (50)    NULL,
    [CustomerType]    VARCHAR (100)   NULL,
    [Reason]          VARCHAR (100)   NULL,
    [SubReason]       VARCHAR (100)   NULL,
    [CaseAge]         DECIMAL (5, 2)  NULL,
    [SLA]             DECIMAL (5, 2)  NULL,
    [FCR]             VARCHAR (50)    NULL,
    [Sentiment]       DECIMAL (5, 2)  NULL,
    [Magnitude]       DECIMAL (5, 2)  NULL,
    [Emotion]         VARCHAR (50)    NULL,
    [Email]           INT             NULL,
    [CSAT]            DECIMAL (10, 2) NULL,
    [AccountId]       VARCHAR (50)    NULL,
    [AccountName]     VARCHAR (250)   NULL,
    [Theatre]         VARCHAR (100)   NULL,
    [AccountTeam]     VARCHAR (50)    NULL,
    [Origin]          VARCHAR (30)    NULL,
    [CreatedDate]     DATETIME        NULL,
    [Status]          VARCHAR (250)   NULL,
    [CaseOwnerRole]   VARCHAR (100)   NULL,
    [CaseId]          VARCHAR (50)    NULL,
    [ClosedDate]      DATETIME        NULL,
    [RelatedIncident] VARCHAR (100)   NULL,
    [ATEscalation]    VARCHAR (100)   NULL,
    [Instance]        VARCHAR (100)   NULL,
    [AtRisk]          VARCHAR (200)   NULL,
    [Feature]         VARCHAR (200)   NULL,
    [SubFeature]      VARCHAR (200)   NULL,
    [ActiveMRR]       MONEY           NULL,
    [FCR_New]         VARCHAR (20)    NULL,
    [MICS_Neutral]    DECIMAL (5, 2)  NULL,
    [MICS_Negative]   DECIMAL (5, 2)  NULL,
    [MICS_Positive]   DECIMAL (5, 2)  NULL,
    [CaseOwner]       VARCHAR (100)   NULL,
    [Priority]        VARCHAR (30)    NULL
);

