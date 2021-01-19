﻿CREATE TABLE [dbo].[Surveys3] (
    [ID]                     VARCHAR (50)  NOT NULL,
    [AccountID]              VARCHAR (50)  NULL,
    [CaseNumber]             VARCHAR (50)  NULL,
    [ContactID]              VARCHAR (50)  NULL,
    [CreatedDate]            DATETIME      NULL,
    [CustomerEffort]         VARCHAR (255) NULL,
    [DataCollectionId]       VARCHAR (50)  NULL,
    [DataCollectionName]     VARCHAR (500) NULL,
    [FirstContactResolution] VARCHAR (255) NULL,
    [LastModifiedDate]       DATETIME      NULL,
    [OrigAccountId]          VARCHAR (50)  NULL,
    [OrigPartnerId]          VARCHAR (50)  NULL,
    [PartnerComment]         TEXT          NULL,
    [PartnerSTID]            VARCHAR (50)  NULL,
    [PartnerScore]           INT           NULL,
    [PrimaryComment]         TEXT          NULL,
    [PrimaryScore]           INT           NULL,
    [Product]                VARCHAR (500) NULL,
    [ProductComent]          TEXT          NULL,
    [RepEffectiveness]       VARCHAR (255) NULL,
    [RepProfessionalism]     VARCHAR (255) NULL,
    [RepResponsiveness]      VARCHAR (255) NULL,
    [RepSpeedToRespond]      VARCHAR (255) NULL,
    [RepTechKnowledge]       VARCHAR (255) NULL,
    [ResponseReceivedDate]   DATETIME      NULL,
    [Status]                 VARCHAR (50)  NULL,
    [StatusDesc]             VARCHAR (500) NULL,
    [ContactName]            VARCHAR (500) NULL,
    [ContactEmail]           VARCHAR (500) NULL
);
