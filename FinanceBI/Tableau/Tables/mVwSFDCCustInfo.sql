CREATE TABLE [Tableau].[mVwSFDCCustInfo] (
    [SfdcId]                            VARCHAR (50)  COLLATE Latin1_General_BIN NOT NULL,
    [AccountId]                         VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [PartnerName]                       VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [CSD_MA]                            VARCHAR (150) COLLATE Latin1_General_BIN NULL,
    [Employees]                         NUMERIC (18)  NULL,
    [CSM]                               VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [PartnerName_Onsite]                VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [AccountTeam]                       VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [BOSS_Support_Partner__c]           VARCHAR (25)  COLLATE Latin1_General_BIN NULL,
    [MiCloud_Connect_Business_Model__c] VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [PartnerDisplayName__c]             VARCHAR (125) COLLATE Latin1_General_BIN NULL,
    [PartnerSupportEmailAddress__c]     VARCHAR (150) COLLATE Latin1_General_BIN NULL,
    [PartnerSupportInformation__c]      VARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [PartnerSupportPhoneNumber__c]      VARCHAR (40)  COLLATE Latin1_General_BIN NULL,
    [PartnerSupportWebPage__c]          VARCHAR (255) COLLATE Latin1_General_BIN NULL,
    [Support_Partner_Enabled__c]        VARCHAR (5)   COLLATE Latin1_General_BIN NULL,
    [PartnerOfRecordCloudSAPNumber]     VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [rn]                                BIGINT        NULL
);

