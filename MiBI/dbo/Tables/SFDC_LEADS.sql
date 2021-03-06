﻿CREATE TABLE [dbo].[SFDC_LEADS] (
    [ID]                                NVARCHAR (255) NULL,
    [LASTNAME]                          NVARCHAR (255) NULL,
    [FIRSTNAME]                         NVARCHAR (255) NULL,
    [SALUTATION]                        NVARCHAR (255) NULL,
    [RECORDTYPEID]                      NVARCHAR (255) NULL,
    [TITLE]                             NVARCHAR (255) NULL,
    [COMPANY]                           NVARCHAR (255) NULL,
    [PHONE]                             NVARCHAR (255) NULL,
    [MOBILEPHONE]                       NVARCHAR (255) NULL,
    [FAX]                               NVARCHAR (255) NULL,
    [EMAIL]                             NVARCHAR (255) NULL,
    [LEADSOURCE]                        NVARCHAR (255) NULL,
    [STATUS]                            NVARCHAR (255) NULL,
    [INDUSTRY]                          NVARCHAR (255) NULL,
    [OWNERID]                           NVARCHAR (255) NULL,
    [CONVERTEDDATE]                     DATETIME       NULL,
    [CREATEDDATE]                       DATETIME       NULL,
    [ASSOCIATED_PARTNER__C]             NVARCHAR (255) NULL,
    [SHORETEL_EXCLUSIVE__C]             BIT            NOT NULL,
    [CONVERSIONCLONE__C]                BIT            NOT NULL,
    [ACTUAL_DB_INDUSTRY_DESCRIPTION__C] NVARCHAR (255) NULL,
    [CURRENT_PHONE_SYSTEM__C]           NVARCHAR (255) NULL,
    [LEAD_RATING_IMAGE__C]              NVARCHAR (255) NULL,
    [DUNS_NUMBER__C]                    FLOAT (53)     NULL,
    [MULTIPLE_OFFICE_LOCATIONS__C]      NVARCHAR (255) NULL,
    [OFFER_TYPE__C]                     NVARCHAR (255) NULL,
    [MOST_RECENT_LEAD_SOURCE__C]        NVARCHAR (255) NULL,
    [PARTNER_ASSIGNED_DATE__C]          DATETIME       NULL,
    [PRODUCT_OF_INTEREST__C]            NVARCHAR (255) NULL,
    [REGION__C]                         NVARCHAR (255) NULL,
    [SIC_CODE__C]                       FLOAT (53)     NULL,
    [TIMING__C]                         NVARCHAR (255) NULL,
    [WEB_REFERENCE_SOURCE__C]           NVARCHAR (255) NULL,
    [OUTCOME__C]                        NVARCHAR (255) NULL,
    [SHORETEL_LEAD_ID__C]               NVARCHAR (255) NULL,
    [PARTNER_ACCEPTED_DATE__C]          DATETIME       NULL,
    [LAST_WEBSITE_VISIT_DATE__C]        DATETIME       NULL,
    [LEAD_COUNTRY__C]                   NVARCHAR (255) NULL,
    [LEAD_US_STATE__C]                  NVARCHAR (255) NULL,
    [QUAL_SCORE__C]                     FLOAT (53)     NULL,
    [INT_SCORE__C]                      FLOAT (53)     NULL,
    [LEAD_SCORE__C]                     NVARCHAR (255) NULL,
    [TELEPHONE_USERS__C]                NVARCHAR (255) NULL,
    [QUALIFYING_NAS_REP__C]             NVARCHAR (255) NULL,
    [D_B_NUMBER_OF_EMPLOYEES__C]        FLOAT (53)     NULL,
    [LEAD_THEATER__C]                   NVARCHAR (255) NULL,
    [LEAD_REGION__C]                    NVARCHAR (255) NULL,
    [LEAD_SUB_REGION__C]                NVARCHAR (255) NULL,
    [QUALIFIED_DATE__C]                 DATETIME       NULL,
    [FIRST_CAMPAIGN__C]                 NVARCHAR (255) NULL,
    [CAMPAIGN_DEPARTMENT__C]            NVARCHAR (255) NULL,
    [LAST_MARKETING_ACTIVITY_DATE__C]   DATETIME       NULL,
    [COMPANY_PHONE__C]                  NVARCHAR (255) NULL,
    [IS_A_MOBILITY_LEAD__C]             BIT            NOT NULL,
    [ASSOCIATED_OPPORTUNITY__C]         VARCHAR (50)   NULL,
    [PARTNER_NAME]                      VARCHAR (100)  NULL,
    [CAMPAIGN_NAME]                     VARCHAR (50)   NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SFDC_LEADS] TO [Marketing]
    AS [dbo];

