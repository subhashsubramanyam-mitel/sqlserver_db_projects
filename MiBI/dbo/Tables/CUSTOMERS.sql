CREATE TABLE [dbo].[CUSTOMERS] (
    [Created]                                  DATETIME        CONSTRAINT [DF_CUSTOMERS2_Created_2] DEFAULT (getdate()) NOT NULL,
    [SfdcCreateDateUTC]                        DATETIME        NULL,
    [SfdcLastUpdateDateUTC]                    DATETIME        NULL,
    [SfdcId]                                   VARCHAR (50)    NOT NULL,
    [End_User_Csn]                             VARCHAR (50)    NULL,
    [ImpactNumber]                             VARCHAR (50)    NULL,
    [NAME]                                     VARCHAR (100)   NOT NULL,
    [Partner_Csn]                              VARCHAR (50)    NULL,
    [PartnerSfdcId]                            VARCHAR (50)    NULL,
    [PartnerId]                                VARCHAR (50)    NULL,
    [SupportType]                              VARCHAR (100)   NULL,
    [Region]                                   VARCHAR (50)    NULL,
    [VersionFromSR]                            VARCHAR (50)    NULL,
    [DbNum]                                    VARCHAR (50)    NULL,
    [SicCode]                                  VARCHAR (50)    NULL,
    [DistyId]                                  VARCHAR (15)    NULL,
    [DistySfdcId]                              VARCHAR (50)    NULL,
    [SupportPrice]                             DECIMAL (18, 2) NULL,
    [Country]                                  VARCHAR (100)   NULL,
    [Type]                                     VARCHAR (50)    NULL,
    [Address]                                  VARCHAR (300)   NULL,
    [City]                                     VARCHAR (100)   NULL,
    [State]                                    VARCHAR (100)   NULL,
    [Zipcode]                                  VARCHAR (50)    NULL,
    [Phone]                                    VARCHAR (50)    NULL,
    [Status]                                   VARCHAR (50)    NULL,
    [AxCode]                                   VARCHAR (50)    NULL,
    [DiscountType]                             VARCHAR (50)    NULL,
    [LastSyncDate]                             DATETIME        NULL,
    [Opportunity_Registration_Expiration_Date] DATETIME        NULL,
    [Cust_Disc]                                DECIMAL (18, 2) NULL,
    [RecPartnerId]                             VARCHAR (50)    NULL,
    [RecPartnerName]                           VARCHAR (100)   NULL,
    [RecPartnerDisc]                           DECIMAL (18, 2) NULL,
    [OrigPartnerId]                            VARCHAR (50)    NULL,
    [OrigPartnerName]                          VARCHAR (100)   NULL,
    [OrigPartnerDisc]                          DECIMAL (18, 2) NULL,
    [GAPAccount]                               VARCHAR (10)    NULL,
    [SECreatedDate]                            DATETIME        NULL,
    [STTerritory]                              VARCHAR (80)    NULL,
    [OwnerName]                                VARCHAR (100)   NULL,
    [OwnerEmail]                               VARCHAR (100)   NULL,
    [ParentSTID]                               VARCHAR (50)    NULL,
    [PriContactLastName]                       VARCHAR (100)   NULL,
    [PriContactFirstName]                      VARCHAR (100)   NULL,
    [PriContactEmail]                          VARCHAR (100)   NULL,
    [PriContactPhone]                          VARCHAR (100)   NULL,
    [Theater]                                  VARCHAR (100)   NULL,
    [DistributorDiscount]                      DECIMAL (18, 2) NULL,
    [SupportSKU]                               VARCHAR (50)    NULL,
    [SupportEndDate]                           DATETIME        NULL,
    [GOVAccount]                               VARCHAR (50)    NULL,
    [GOVClass]                                 VARCHAR (100)   NULL,
    [CustomerType]                             VARCHAR (100)   NULL,
    [M5DBAccountID]                            VARCHAR (50)    NULL,
    [StateCode]                                VARCHAR (50)    NULL,
    [CountryCode]                              VARCHAR (50)    NULL,
    [CSM]                                      VARCHAR (100)   NULL,
    [ReferredbyPartnerID]                      VARCHAR (100)   NULL,
    [Instance]                                 VARCHAR (100)   NULL,
    [AccountTeam]                              VARCHAR (100)   NULL,
    [IvarRecDisc]                              DECIMAL (18, 2) NULL,
    [Industry]                                 VARCHAR (MAX)   NULL,
    [FirstInvoice]                             DATETIME        NULL,
    [DbNumOfEmployees]                         VARCHAR (50)    NULL,
    [CloudProfiles]                            NUMERIC (18)    NULL,
    [ConnectCloudProfilesRollup]               NUMERIC (18)    NULL,
    [LegacyCloudProfilesRollup]                NUMERIC (18)    NULL,
    [OnsitePoints]                             NUMERIC (18)    NULL,
    [PartnerCSM]                               VARCHAR (100)   NULL,
    [PartnerOfRecordCloud]                     VARCHAR (25)    NULL,
    [AtRiskNow]                                NUMERIC (18)    CONSTRAINT [DF_CUSTOMERS_AtRiskNow] DEFAULT ((0)) NULL,
    [OnsitePointsRollup]                       NUMERIC (18)    NULL,
    [SAPNumber]                                VARCHAR (50)    NULL,
    [Platform]                                 VARCHAR (50)    NULL,
    [CLOUDPartnerType]                         VARCHAR (50)    NULL,
    [ActiveMRR_Boss]                           FLOAT (53)      NULL,
    [OtherERPNumber]                           VARCHAR (25)    NULL,
    [isMCSS]                                   INT             NULL,
    [CommitmentDate]                           DATETIME        NULL,
    [MCSS1stReminderDate]                      DATETIME        NULL,
    [MCSS2ndReminderDate]                      DATETIME        NULL,
    [MCSSSurveyExpirationDate]                 DATETIME        NULL,
    [MCSSSurveySent]                           DATETIME        NULL,
    [MCSSSurveyStatus]                         VARCHAR (50)    NULL,
    [CSD_MA]                                   VARCHAR (150)   NULL,
    [NodeEmployeeCount]                        NUMERIC (18)    NULL,
    [CCProfiles_boss]                          FLOAT (53)      NULL,
    [UCaaSAccountOwner]                        VARCHAR (150)   NULL,
    [RecordType]                               VARCHAR (100)   NULL,
    [BOSS_Support_Partner__c]                  VARCHAR (25)    NULL,
    [MiCloud_Connect_Business_Model__c]        VARCHAR (100)   NULL,
    [PartnerDisplayName__c]                    VARCHAR (125)   NULL,
    [PartnerSupportEmailAddress__c]            VARCHAR (150)   NULL,
    [PartnerSupportInformation__c]             VARCHAR (255)   NULL,
    [PartnerSupportPhoneNumber__c]             VARCHAR (40)    NULL,
    [PartnerSupportWebPage__c]                 VARCHAR (255)   NULL,
    [Support_Partner_Enabled__c]               VARCHAR (5)     NULL,
    CONSTRAINT [PK_CUSTOMERS2_2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_Customers_Name]
    ON [dbo].[CUSTOMERS]([NAME] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_Customers_Status]
    ON [dbo].[CUSTOMERS]([Status] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[CUSTOMERS] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[CUSTOMERS] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMERS] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[CUSTOMERS] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[CUSTOMERS] TO [TACECC]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'sync from boss', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CUSTOMERS', @level2type = N'COLUMN', @level2name = N'isMCSS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'sync from boss', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CUSTOMERS', @level2type = N'COLUMN', @level2name = N'CommitmentDate';

