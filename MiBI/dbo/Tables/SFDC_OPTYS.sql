CREATE TABLE [dbo].[SFDC_OPTYS] (
    [OPTY_ID]                   NVARCHAR (255) NULL,
    [NAME]                      NVARCHAR (255) NULL,
    [AMOUNT]                    FLOAT (53)     NULL,
    [QMS_ORDER_NUMBER__C]       NVARCHAR (255) NULL,
    [QMS_QUOTE_NUMBER__C]       NVARCHAR (255) NULL,
    [QMS_ORDER_STATUS__C]       NVARCHAR (255) NULL,
    [LEADSOURCE]                NVARCHAR (255) NULL,
    [CLOSEDATE]                 DATETIME       NULL,
    [STAGENAME]                 NVARCHAR (255) NULL,
    [CAMPAIGN_DEPARTMENT__C]    NVARCHAR (255) NULL,
    [TYPE]                      NVARCHAR (255) NULL,
    [ACCOUNTID]                 NVARCHAR (255) NULL,
    [ACCOUNT_NAME]              NVARCHAR (255) NULL,
    [NUM_OF_TELEPHONE_USERS__C] NVARCHAR (255) NULL,
    [OPPORTUNITY_COUNT__C]      FLOAT (53)     NULL,
    [PARTNER_ACCOUNT__C]        NVARCHAR (255) NULL,
    [RECORDTYPEID]              NVARCHAR (255) NULL,
    [TOTAL_SALES__C]            FLOAT (53)     NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SFDC_OPTYS] TO [Marketing]
    AS [dbo];

