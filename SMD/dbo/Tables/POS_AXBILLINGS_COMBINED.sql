CREATE TABLE [dbo].[POS_AXBILLINGS_COMBINED] (
    [Source]                 VARCHAR (3)      NOT NULL,
    [OrderDate]              DATETIME         NULL,
    [Invoice]                NVARCHAR (100)   NULL,
    [VADId]                  VARCHAR (15)     NULL,
    [VADName]                NVARCHAR (100)   NULL,
    [InvoiceDate]            DATETIME         NULL,
    [SalesOrder]             NVARCHAR (100)   NULL,
    [CustomerPo]             NVARCHAR (100)   NULL,
    [ImpactNumber]           NVARCHAR (50)    NULL,
    [BillToName]             NVARCHAR (100)   NULL,
    [EndCust]                NVARCHAR (50)    NULL,
    [EndCustName]            NVARCHAR (100)   NULL,
    [SKU]                    NVARCHAR (50)    NULL,
    [QTY]                    NUMERIC (28, 12) NULL,
    [NetSalesUSD]            NUMERIC (38, 6)  NULL,
    [ShipPostalCode]         NVARCHAR (50)    NULL,
    [ShipCity]               NVARCHAR (100)   NULL,
    [ShipState]              NVARCHAR (100)   NULL,
    [ShipCountry]            NVARCHAR (100)   NULL,
    [StockCode]              NVARCHAR (255)   NULL,
    [ItemDesc]               NVARCHAR (1000)  NULL,
    [CUSTGROUP]              NVARCHAR (30)    NULL,
    [OrigSalesOrder]         NVARCHAR (100)   NULL,
    [OrderType]              NVARCHAR (10)    NULL,
    [GMFamily]               VARCHAR (50)     NULL,
    [PartnerGId]             NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]               NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [RevType]                VARCHAR (10)     NOT NULL,
    [PartnerId]              NVARCHAR (50)    NULL,
    [Partner]                NVARCHAR (100)   NULL,
    [AX_InvoiceDateUTC]      DATETIME         NULL,
    [ItemGroupName]          NVARCHAR (100)   NULL,
    [SC_Billings]            NUMERIC (38, 6)  NULL,
    [ItemCost]               NUMERIC (28, 12) NOT NULL,
    [RequestedShipDate]      DATETIME         NULL,
    [SalesPoolId]            NVARCHAR (30)    NULL,
    [EndCustCreateDate]      DATETIME         NULL,
    [CurrencyCode]           NVARCHAR (3)     NOT NULL,
    [NetSalesLocalCurrency]  NUMERIC (28, 12) NULL,
    [SC_VARId]               NVARCHAR (50)    NULL,
    [ItemSubType]            VARCHAR (100)    COLLATE Latin1_General_BIN NULL,
    [InvoiceDate_DateFormat] DATE             NULL,
    [FYQuarter]              VARCHAR (7)      NULL,
    [NetSalesPlanRate]       NUMERIC (38, 6)  NULL,
    [GOVAccount]             VARCHAR (50)     NULL,
    [GOVClass]               VARCHAR (50)     NULL,
    [Connect]                VARCHAR (50)     NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_POS_AXBILLINGS_COMBINED-Idate]
    ON [dbo].[POS_AXBILLINGS_COMBINED]([InvoiceDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_POS_AXBILLINGS_COMBINED-rt]
    ON [dbo].[POS_AXBILLINGS_COMBINED]([RevType] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_POS_AXBILLINGS_COMBINED-SKU]
    ON [dbo].[POS_AXBILLINGS_COMBINED]([SKU] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[POS_AXBILLINGS_COMBINED] TO [POS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[POS_AXBILLINGS_COMBINED] TO [nkleinberg]
    AS [dbo];

