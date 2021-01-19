﻿CREATE TABLE [dbo].[DNB_DATA] (
    [Created]                                 DATETIME       CONSTRAINT [DF_DNB_DATA_Created] DEFAULT (getdate()) NULL,
    [SE_ID]                                   NVARCHAR (255) NOT NULL,
    [DUNS]                                    CHAR (9)       NULL,
    [SIC1]                                    VARCHAR (50)   NULL,
    [Total Employees]                         FLOAT (53)     NULL,
    [Major Industry Category]                 FLOAT (53)     NULL,
    [Customer Defined Field 1]                FLOAT (53)     NULL,
    [Customer Defined Field 2]                NVARCHAR (255) NULL,
    [Customer Defined Field 3]                NVARCHAR (255) NULL,
    [Customer Defined Field 4]                NVARCHAR (255) NULL,
    [Company Name]                            NVARCHAR (255) NULL,
    [Primary Address 1]                       NVARCHAR (255) NULL,
    [PO Box]                                  NVARCHAR (255) NULL,
    [City]                                    NVARCHAR (255) NULL,
    [State]                                   NVARCHAR (255) NULL,
    [Zip]                                     FLOAT (53)     NULL,
    [Country]                                 NVARCHAR (255) NULL,
    [Phone]                                   NVARCHAR (255) NULL,
    [Sequence Number]                         FLOAT (53)     NULL,
    [Match Code]                              NVARCHAR (255) NULL,
    [BEMFAB]                                  NVARCHAR (255) NULL,
    [MatchGrade]                              NVARCHAR (255) NULL,
    [Confidence Code]                         FLOAT (53)     NULL,
    [Accuracy %]                              FLOAT (53)     NULL,
    [Name MDP Code]                           FLOAT (53)     NULL,
    [Street Number MDP Code]                  FLOAT (53)     NULL,
    [Street Name MDP Code]                    FLOAT (53)     NULL,
    [City MDP Code]                           FLOAT (53)     NULL,
    [State/Province MDP Code]                 FLOAT (53)     NULL,
    [PO Box MDP Code]                         FLOAT (53)     NULL,
    [Phone MDP Code]                          FLOAT (53)     NULL,
    [Zip MDP code]                            FLOAT (53)     NULL,
    [SIC MDP Code]                            FLOAT (53)     NULL,
    [Density MDP Code]                        FLOAT (53)     NULL,
    [Uniqueness MDP Code]                     FLOAT (53)     NULL,
    [Customer Address DSF Code]               FLOAT (53)     NULL,
    [Physical Address Type Code]              NVARCHAR (255) NULL,
    [Physical Address DSF Code]               FLOAT (53)     NULL,
    [Mailing Addres Type Code]                NVARCHAR (255) NULL,
    [Mailing Address DSF Code]                FLOAT (53)     NULL,
    [Physical Address Vacancy Code]           NVARCHAR (255) NULL,
    [Mailing Address Vacancy Code]            NVARCHAR (255) NULL,
    [Physical Address Delivery Type Code]     NVARCHAR (255) NULL,
    [Mailing Address Delivery Type Code]      NVARCHAR (255) NULL,
    [DSF Physical Addres Type Match Flag]     NVARCHAR (255) NULL,
    [DSF Mailing Address Type Match Flag]     NVARCHAR (255) NULL,
    [CMRA Code - Physical Address]            NVARCHAR (255) NULL,
    [CMRA Code - Mailing Address]             NVARCHAR (255) NULL,
    [Correction Opportunity Indicator]        NVARCHAR (255) NULL,
    [10 Zero's]                               FLOAT (53)     NULL,
    [DUNS1]                                   FLOAT (53)     NULL,
    [Business Name]                           NVARCHAR (255) NULL,
    [Trade Style Name]                        NVARCHAR (255) NULL,
    [Second Trade Style Name]                 NVARCHAR (255) NULL,
    [Primary Address Line 1]                  NVARCHAR (255) NULL,
    [Primary Address Line 2]                  NVARCHAR (255) NULL,
    [City Name]                               NVARCHAR (255) NULL,
    [State1]                                  NVARCHAR (255) NULL,
    [Zip Code]                                FLOAT (53)     NULL,
    [Country Name]                            NVARCHAR (255) NULL,
    [State Province Name]                     NVARCHAR (255) NULL,
    [County Name]                             NVARCHAR (255) NULL,
    [Filler]                                  NVARCHAR (255) NULL,
    [Latitude]                                FLOAT (53)     NULL,
    [Longitude]                               FLOAT (53)     NULL,
    [Mailing Address Line 1]                  NVARCHAR (255) NULL,
    [Mailing Address Line 2]                  NVARCHAR (255) NULL,
    [Mailing City]                            NVARCHAR (255) NULL,
    [Mailing State Abbreviation]              NVARCHAR (255) NULL,
    [Mailing Zip code]                        FLOAT (53)     NULL,
    [Carrier Route Code]                      NVARCHAR (255) NULL,
    [Continent Code]                          FLOAT (53)     NULL,
    [Country Code]                            FLOAT (53)     NULL,
    [D&B State Code]                          FLOAT (53)     NULL,
    [D&B City Code]                           FLOAT (53)     NULL,
    [D&B County Code]                         FLOAT (53)     NULL,
    [SMSA Code]                               FLOAT (53)     NULL,
    [Filler1]                                 NVARCHAR (255) NULL,
    [FIPS Country Code]                       NVARCHAR (255) NULL,
    [FIPS State Code]                         FLOAT (53)     NULL,
    [FIPS County Code]                        FLOAT (53)     NULL,
    [FIPS MSA code]                           FLOAT (53)     NULL,
    [Latitude1]                               FLOAT (53)     NULL,
    [Longitude1]                              FLOAT (53)     NULL,
    [GEO Accuracy]                            NVARCHAR (255) NULL,
    [Phone Number]                            FLOAT (53)     NULL,
    [Phone Country Code]                      FLOAT (53)     NULL,
    [Telx Number]                             NVARCHAR (255) NULL,
    [Fax Number]                              FLOAT (53)     NULL,
    [CEO Full Name]                           NVARCHAR (255) NULL,
    [CEO First Name]                          NVARCHAR (255) NULL,
    [CEO Middle Name]                         NVARCHAR (255) NULL,
    [CEO Last Name]                           NVARCHAR (255) NULL,
    [CEO Suffix Title]                        NVARCHAR (255) NULL,
    [CEO Prefix title]                        NVARCHAR (255) NULL,
    [CEO Title]                               NVARCHAR (255) NULL,
    [CEO MRC]                                 NVARCHAR (255) NULL,
    [CEO Gender code]                         NVARCHAR (255) NULL,
    [Sales Volume]                            FLOAT (53)     NULL,
    [Sales Volume Code]                       FLOAT (53)     NULL,
    [Sales Amount]                            FLOAT (53)     NULL,
    [Annual Sales Local Currency]             FLOAT (53)     NULL,
    [Currency Code]                           FLOAT (53)     NULL,
    [Total Employees Code]                    FLOAT (53)     NULL,
    [Total Employees Here]                    FLOAT (53)     NULL,
    [Employees Here Reliability Code]         FLOAT (53)     NULL,
    [Year Started]                            FLOAT (53)     NULL,
    [Status Indicator]                        FLOAT (53)     NULL,
    [Subsidiary Indicator]                    FLOAT (53)     NULL,
    [Manufacturing Indicator]                 FLOAT (53)     NULL,
    [Population Code]                         FLOAT (53)     NULL,
    [Small Business Indicator]                NVARCHAR (255) NULL,
    [Minority Owned and Operatored Indicator] NVARCHAR (255) NULL,
    [Public/Private Indicator]                NVARCHAR (255) NULL,
    [Division Indicator]                      NVARCHAR (255) NULL,
    [Site Status]                             NVARCHAR (255) NULL,
    [Legal Status]                            FLOAT (53)     NULL,
    [Import/Export Code]                      NVARCHAR (255) NULL,
    [Own or Rent]                             FLOAT (53)     NULL,
    [Square Footage]                          FLOAT (53)     NULL,
    [Global Ultimate DUNS Number]             FLOAT (53)     NULL,
    [Global Ultimate Business Name]           NVARCHAR (255) NULL,
    [Global Ultimate Indicator]               NVARCHAR (255) NULL,
    [Global Ultimate FIPS Country Code]       FLOAT (53)     NULL,
    [Global Ultimate Country Code]            FLOAT (53)     NULL,
    [Global Ultimate State Abbreviation]      NVARCHAR (255) NULL,
    [Domestic Ultimate DUNS Number]           FLOAT (53)     NULL,
    [Domestic Ultimate Business Name]         NVARCHAR (255) NULL,
    [Domestic Ultimate FIPS Country Code]     FLOAT (53)     NULL,
    [Domestic Ultimate Country Code]          FLOAT (53)     NULL,
    [Domestic Ultimate State Abbreviation]    NVARCHAR (255) NULL,
    [Parent DUNS Number]                      NVARCHAR (255) NULL,
    [Headquarters DUNS Number]                FLOAT (53)     NULL,
    [Parent Business Name]                    NVARCHAR (255) NULL,
    [Parent Headquarters FIPS Country Code]   FLOAT (53)     NULL,
    [Parent Headquarters Country Code]        FLOAT (53)     NULL,
    [Parent Headquarters State Abbreviation]  NVARCHAR (255) NULL,
    [Heirarchy Code]                          FLOAT (53)     NULL,
    [DIAS Code]                               FLOAT (53)     NULL,
    [Number of Family Members]                FLOAT (53)     NULL,
    [Family Update Date]                      NVARCHAR (255) NULL,
    [Line of Business]                        NVARCHAR (255) NULL,
    [SIC1_old]                                FLOAT (53)     NULL,
    [SIC2]                                    FLOAT (53)     NULL,
    [SIC3]                                    NVARCHAR (255) NULL,
    [SIC4]                                    NVARCHAR (255) NULL,
    [SIC5]                                    NVARCHAR (255) NULL,
    [SIC6]                                    NVARCHAR (255) NULL,
    [National Identification Number]          NVARCHAR (255) NULL,
    [Primary Local Activity Code]             NVARCHAR (255) NULL,
    [Percentage Sales Growth over 3 years]    FLOAT (53)     NULL,
    [Employee Growth over 3 years]            FLOAT (53)     NULL,
    [Sales Amount over 3 years]               FLOAT (53)     NULL,
    [Employees Trend over 3 years]            FLOAT (53)     NULL,
    [Percentage Sales Growth over 5 years]    FLOAT (53)     NULL,
    [Employee Growth over 5 years]            FLOAT (53)     NULL,
    [Sales Amount over 5 years]               FLOAT (53)     NULL,
    [Employees Trend over 5 years]            FLOAT (53)     NULL,
    [Base Year sales]                         FLOAT (53)     NULL,
    [Base Year Employees]                     FLOAT (53)     NULL,
    [Bank DUNS Number]                        NVARCHAR (255) NULL,
    [Bank Name]                               NVARCHAR (255) NULL,
    [Bank Address]                            NVARCHAR (255) NULL,
    [Bank City]                               NVARCHAR (255) NULL,
    [Bank State]                              NVARCHAR (255) NULL,
    [Bank Zip Code]                           NVARCHAR (255) NULL,
    [Account Firm Name]                       NVARCHAR (255) NULL,
    [Filler2]                                 NVARCHAR (255) NULL,
    [Filler3]                                 NVARCHAR (255) NULL,
    [Filler4]                                 NVARCHAR (255) NULL,
    [Filler5]                                 NVARCHAR (255) NULL,
    [Filler6]                                 NVARCHAR (255) NULL,
    [Filler7]                                 NVARCHAR (255) NULL,
    [Filler8]                                 NVARCHAR (255) NULL,
    [Filler9]                                 NVARCHAR (255) NULL,
    [First Executive First Name]              NVARCHAR (255) NULL,
    [First Executive Middle Name]             NVARCHAR (255) NULL,
    [First Executive Last Name]               NVARCHAR (255) NULL,
    [First Executive Suffix Title]            NVARCHAR (255) NULL,
    [First Executive Prefix Title]            NVARCHAR (255) NULL,
    [First Executive Title]                   NVARCHAR (255) NULL,
    [First Executive MRC]                     NVARCHAR (255) NULL,
    [Second Executive First Name]             NVARCHAR (255) NULL,
    [Second Executive Middle Name]            NVARCHAR (255) NULL,
    [Second Executive Last Name]              NVARCHAR (255) NULL,
    [Second Executive Suffix Title]           NVARCHAR (255) NULL,
    [Second Executive Prefix Title]           NVARCHAR (255) NULL,
    [Second Executive Title]                  NVARCHAR (255) NULL,
    [Second Executive MRC]                    NVARCHAR (255) NULL,
    [Third Executive First Name]              NVARCHAR (255) NULL,
    [Third Executive Middle Name]             NVARCHAR (255) NULL,
    [Third Executive Last Name]               NVARCHAR (255) NULL,
    [Third Executive Suffix Title]            NVARCHAR (255) NULL,
    [Third Executive Prefix Title]            NVARCHAR (255) NULL,
    [Third Executive Title]                   NVARCHAR (255) NULL,
    [Third Executive MRC]                     NVARCHAR (255) NULL,
    [FIPS City Code]                          VARCHAR (100)  NULL,
    [Segmentation Cluster]                    FLOAT (53)     NULL,
    [Marketing PreScreen]                     NVARCHAR (255) NULL,
    [Primary NAICS 1_1 Code]                  FLOAT (53)     NULL,
    [Primary NAICS 1_2 Code]                  NVARCHAR (255) NULL,
    [Primary NAICS 1_3 Code]                  NVARCHAR (255) NULL,
    [Primary NAICS 1_4 Code]                  NVARCHAR (255) NULL,
    [NAICS 2_1 Code]                          FLOAT (53)     NULL,
    [NAICS 2_2 Code]                          NVARCHAR (255) NULL,
    [NAICS 2_3 Code]                          NVARCHAR (255) NULL,
    [NAICS 2_4 Code]                          NVARCHAR (255) NULL,
    [NAICS 3_1 Code]                          NVARCHAR (255) NULL,
    [NAICS 3_2 Code]                          NVARCHAR (255) NULL,
    [NAICS 3_3 Code]                          NVARCHAR (255) NULL,
    [NAICS 3_4 Code]                          NVARCHAR (255) NULL,
    [NAICS 4_1 Code]                          NVARCHAR (255) NULL,
    [NAICS 4_2 Code]                          NVARCHAR (255) NULL,
    [NAICS 4_3 Code]                          NVARCHAR (255) NULL,
    [NAICS 4_4 Code]                          NVARCHAR (255) NULL,
    [NAICS 5_1 Code]                          NVARCHAR (255) NULL,
    [NAICS 5_2 Code]                          NVARCHAR (255) NULL,
    [NAICS 5_3 Code]                          NVARCHAR (255) NULL,
    [NAICS 5_4 Code]                          NVARCHAR (255) NULL,
    [NAICS 6_1 Code]                          NVARCHAR (255) NULL,
    [NAICS 6_2 Code]                          NVARCHAR (255) NULL,
    [NAICS 6_3 Code]                          NVARCHAR (255) NULL,
    [NAICS 6_4 Code]                          NVARCHAR (255) NULL,
    [ST_ID]                                   VARCHAR (50)   NULL,
    [SfdcId]                                  VARCHAR (50)   NULL,
    CONSTRAINT [PK_DNB_DATA] PRIMARY KEY CLUSTERED ([SE_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DNB_DATA_ST_ID]
    ON [dbo].[DNB_DATA]([ST_ID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DNB_DATA] TO [DnBData]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DNB_DATA] TO [PMData]
    AS [dbo];
