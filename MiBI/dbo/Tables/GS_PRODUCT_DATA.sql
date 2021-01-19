CREATE TABLE [dbo].[GS_PRODUCT_DATA] (
    [OrderDate]      DATETIME         NULL,
    [ShipDate]       DATETIME         NULL,
    [SalesOrder]     VARCHAR (15)     NULL,
    [Quarter]        VARCHAR (15)     NULL,
    [InvoiceNumber]  VARCHAR (50)     NULL,
    [PartnerG]       VARCHAR (50)     NULL,
    [CustGroupDesc]  VARCHAR (50)     NULL,
    [CustSoldToName] VARCHAR (100)    NULL,
    [EndCustName]    VARCHAR (100)    NULL,
    [Size]           VARCHAR (8)      NULL,
    [Employees]      FLOAT (53)       NULL,
    [Vertical]       VARCHAR (100)    NULL,
    [SIC]            VARCHAR (25)     NULL,
    [REVtype]        VARCHAR (25)     NULL,
    [TYPE]           VARCHAR (25)     NULL,
    [GMFamily]       VARCHAR (25)     NULL,
    [EndCustBuild]   VARCHAR (25)     NULL,
    [StockCode]      VARCHAR (25)     NULL,
    [Sku]            VARCHAR (25)     NULL,
    [STRelease]      VARCHAR (50)     NULL,
    [NetUSD]         NUMERIC (28, 12) NULL,
    [ListPrice]      NUMERIC (28, 12) NULL,
    [PromoPrice]     NUMERIC (28, 12) NULL,
    [StdCost]        NUMERIC (28, 12) NULL,
    [EndCust]        VARCHAR (25)     NULL,
    [StockCodeDesc]  VARCHAR (100)    NULL,
    [Qty]            INT              NULL,
    [StdCogsUSD]     NUMERIC (28, 12) NULL,
    [StdMgnUSD]      NUMERIC (28, 12) NULL,
    [ProductClass]   VARCHAR (50)     NULL,
    [SalesArea]      VARCHAR (50)     NULL,
    [RVP]            VARCHAR (50)     NULL,
    [RD]             VARCHAR (50)     NULL,
    [RegionArea]     VARCHAR (50)     NULL,
    [Channel]        VARCHAR (50)     NULL,
    [Fyear]          VARCHAR (10)     NULL,
    [Fquarter]       VARCHAR (10)     NULL,
    [FiscalMonth]    VARCHAR (10)     NULL,
    [Country]        VARCHAR (50)     NULL,
    [ShipState]      VARCHAR (50)     NULL,
    [ShipCity]       VARCHAR (50)     NULL,
    [CustomerPo]     VARCHAR (100)    NULL,
    [OrderType]      VARCHAR (50)     NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[GS_PRODUCT_DATA] TO [CANDY\srahman]
    AS [dbo];

