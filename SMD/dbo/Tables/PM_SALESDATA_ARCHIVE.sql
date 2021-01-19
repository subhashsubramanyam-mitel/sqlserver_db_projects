CREATE TABLE [dbo].[PM_SALESDATA_ARCHIVE] (
    [Source]                VARCHAR (3)      NOT NULL,
    [OrderDate]             DATETIME         NULL,
    [Invoice]               NVARCHAR (100)   NULL,
    [VADId]                 VARCHAR (15)     NULL,
    [VADName]               NVARCHAR (100)   NULL,
    [InvoiceDate]           DATETIME         NULL,
    [SalesOrder]            NVARCHAR (100)   NULL,
    [CustomerPo]            NVARCHAR (100)   NULL,
    [ImpactNumber]          NVARCHAR (50)    NULL,
    [BillToName]            NVARCHAR (255)   NULL,
    [EndCust]               NVARCHAR (50)    NULL,
    [EndCustName]           NVARCHAR (100)   NULL,
    [SKU]                   NVARCHAR (50)    NULL,
    [QTY]                   NUMERIC (28, 12) NULL,
    [NetSalesUSD]           NUMERIC (38, 6)  NULL,
    [ShipPostalCode]        NVARCHAR (50)    NULL,
    [ShipCity]              NVARCHAR (100)   NULL,
    [ShipState]             NVARCHAR (100)   NULL,
    [ShipCountry]           NVARCHAR (100)   NULL,
    [StockCode]             NVARCHAR (255)   NULL,
    [ItemDesc]              NVARCHAR (1000)  NULL,
    [CUSTGROUP]             NVARCHAR (30)    NULL,
    [OrigSalesOrder]        NVARCHAR (100)   NULL,
    [OrderType]             NVARCHAR (10)    NULL,
    [GMFamily]              VARCHAR (50)     NULL,
    [PartnerGId]            NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]              NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [RevType]               VARCHAR (10)     NOT NULL,
    [PartnerId]             NVARCHAR (50)    NULL,
    [Partner]               NVARCHAR (255)   NULL,
    [AX_InvoiceDateUTC]     DATETIME         NULL,
    [ItemGroupName]         NVARCHAR (100)   NULL,
    [SC_Billings]           NUMERIC (38, 6)  NULL,
    [ItemCost]              NUMERIC (28, 12) NOT NULL,
    [RequestedShipDate]     DATETIME         NULL,
    [SalesPoolId]           VARCHAR (15)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ChampLevel]            VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CustomerVersion]       VARCHAR (50)     COLLATE Latin1_General_BIN NULL,
    [Theatre]               VARCHAR (50)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Region]                NVARCHAR (255)   COLLATE Latin1_General_BIN NULL,
    [CustomerVertical]      NVARCHAR (100)   COLLATE Latin1_General_BIN NULL,
    [CustomerVerticalClass] VARCHAR (50)     COLLATE Latin1_General_BIN NULL,
    [ExtendedNetPriceLocal] NUMERIC (28, 12) NULL,
    [CurrencyCode]          NVARCHAR (3)     NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PM_SALESDATA_ARCHIVE] TO [PM]
    AS [dbo];

