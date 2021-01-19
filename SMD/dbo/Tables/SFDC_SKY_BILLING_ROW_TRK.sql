CREATE TABLE [dbo].[SFDC_SKY_BILLING_ROW_TRK] (
    [Created]              DATETIME         CONSTRAINT [DF_SFDC_SKY_BILLING_ROW_TRK_Created] DEFAULT (getdate()) NULL,
    [SalesOrder]           NVARCHAR (31)    NOT NULL,
    [OrderDate]            DATETIME         NOT NULL,
    [ComDate]              DATETIME         NULL,
    [CustomerSfdcId]       VARCHAR (50)     NOT NULL,
    [PartnerOfRecordCloud] VARCHAR (25)     NULL,
    [PONumber]             NVARCHAR (50)    NULL,
    [IgName]               VARCHAR (100)    NULL,
    [HostedBilling]        NUMERIC (38, 12) NULL,
    [CurrencyCode]         VARCHAR (5)      CONSTRAINT [DF_SFDC_SKY_BILLING_ROW_TRK_CurrencyCode] DEFAULT ('GBP') NULL,
    [Status]               VARCHAR (5)      CONSTRAINT [DF_SFDC_SKY_BILLING_ROW_TRK_Status] DEFAULT ('N') NULL,
    [Error]                TEXT             NULL,
    [BossAccountId]        VARCHAR (25)     NULL,
    CONSTRAINT [PK_SFDC_SKY_BILLING_ROW_TRK] PRIMARY KEY CLUSTERED ([SalesOrder] ASC)
);

