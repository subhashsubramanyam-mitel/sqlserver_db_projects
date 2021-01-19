CREATE TABLE [dbo].[tmpTest] (
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
    [CurrencyCode]          NVARCHAR (3)     NOT NULL,
    [Margin]                NUMERIC (38, 6)  NOT NULL,
    [NetSalesPlanRate]      NUMERIC (28, 12) NULL
);

