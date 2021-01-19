CREATE TABLE [dbo].[SFDC_AX_BILLING_TRK_05282015_2014] (
    [Created]               DATETIME         NULL,
    [RecId]                 BIGINT           NOT NULL,
    [Invoice]               NVARCHAR (20)    NOT NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [OrderType]             NVARCHAR (10)    NULL,
    [EndCustArea]           NVARCHAR (30)    NULL,
    [NetSalesUSD]           NUMERIC (28, 12) NOT NULL,
    [NetSalesLocalCurrency] NUMERIC (28, 12) NOT NULL,
    [InvoiceDate]           DATETIME         NOT NULL,
    [SKU]                   NVARCHAR (20)    NULL,
    [RevType]               VARCHAR (9)      NOT NULL,
    [CurrencyCode]          VARCHAR (5)      NULL,
    [Status]                VARCHAR (5)      NULL,
    [ErrorMsg]              TEXT             NULL,
    [Margin]                NUMERIC (18, 12) NULL
);

