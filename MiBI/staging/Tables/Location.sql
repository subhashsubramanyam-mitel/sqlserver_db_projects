﻿CREATE TABLE [staging].[Location] (
    [Account__c]                  VARCHAR (50)  NULL,
    [Active_Seats__c]             VARCHAR (50)  NULL,
    [boss_Abbrev__c]              VARCHAR (255) NULL,
    [boss_City__c]                VARCHAR (255) NULL,
    [boss_Country__c]             VARCHAR (255) NULL,
    [boss_Demarcation_Point__c]   VARCHAR (MAX) NULL,
    [boss_ForecastDate__c]        DATETIME      NULL,
    [boss_LATA__c]                VARCHAR (50)  NULL,
    [boss_location_id__c]         VARCHAR (50)  NULL,
    [boss_Location_Live__c]       VARCHAR (50)  NULL,
    [boss_NPA__c]                 VARCHAR (50)  NULL,
    [boss_NXX__c]                 VARCHAR (50)  NULL,
    [boss_State__c]               VARCHAR (50)  NULL,
    [boss_Status__c]              VARCHAR (50)  NULL,
    [boss_Subtenant__c]           VARCHAR (50)  NULL,
    [boss_Zip_Code__c]            VARCHAR (50)  NULL,
    [ConnectionReceivedId]        VARCHAR (50)  NULL,
    [ConnectionSentId]            VARCHAR (50)  NULL,
    [Contract_Commitment_Date__c] DATETIME      NULL,
    [CreatedById]                 VARCHAR (50)  NULL,
    [CreatedDate]                 DATETIME      NULL,
    [CurrencyIsoCode]             VARCHAR (50)  NULL,
    [Date_Set_Active__c]          DATETIME      NULL,
    [Id]                          VARCHAR (20)  NOT NULL,
    [Installation_Type__c]        VARCHAR (50)  NULL,
    [IsDeleted]                   VARCHAR (50)  NULL,
    [Is_CX__c]                    VARCHAR (50)  NULL,
    [Is_ECC_SCC__c]               VARCHAR (50)  NULL,
    [Is_Hybrid__c]                VARCHAR (50)  NULL,
    [Is_Migration__c]             VARCHAR (50)  NULL,
    [Is_Mitel_Circuit__c]         VARCHAR (50)  NULL,
    [Is_MPLS__c]                  VARCHAR (50)  NULL,
    [LastActivityDate]            DATETIME      NULL,
    [LastModifiedById]            VARCHAR (50)  NULL,
    [LastModifiedDate]            DATETIME      NULL,
    [LastReferencedDate]          DATETIME      NULL,
    [LastViewedDate]              DATETIME      NULL,
    [Number_of_Locations__c]      VARCHAR (50)  NULL,
    [Opportunity__c]              VARCHAR (50)  NULL,
    [OwnerId]                     VARCHAR (255) NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([Id] ASC)
);

