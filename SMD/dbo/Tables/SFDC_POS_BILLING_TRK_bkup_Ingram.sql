CREATE TABLE [dbo].[SFDC_POS_BILLING_TRK_bkup_Ingram] (
    [Created]               DATETIME         NULL,
    [RecId]                 NVARCHAR (268)   NOT NULL,
    [Invoice]               NVARCHAR (100)   NULL,
    [SalesOrder]            NVARCHAR (100)   NULL,
    [OrderType]             NVARCHAR (10)    NULL,
    [AxTerritory]           NVARCHAR (30)    NULL,
    [NetSalesUSD]           NUMERIC (29, 12) NULL,
    [NetSalesLocalCurrency] NUMERIC (29, 12) NULL,
    [CurrencyCode]          VARCHAR (5)      NULL,
    [InvoiceDate]           DATETIME         NULL,
    [SKU]                   NVARCHAR (50)    NULL,
    [RevType]               VARCHAR (10)     NOT NULL,
    [Status]                VARCHAR (5)      NULL,
    [ErrorMsg]              TEXT             NULL,
    [Margin]                NUMERIC (18, 12) NULL
);

