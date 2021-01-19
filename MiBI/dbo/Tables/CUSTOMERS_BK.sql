﻿CREATE TABLE [dbo].[CUSTOMERS_BK] (
    [Created]                                  DATETIME        NOT NULL,
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
    [PriContactEmail]                          VARCHAR (50)    NULL,
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
    [AtRiskNow]                                INT             NULL,
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
    [NodeEmployeeCount]                        INT             NULL
);
