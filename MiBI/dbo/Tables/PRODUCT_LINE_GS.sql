CREATE TABLE [dbo].[PRODUCT_LINE_GS] (
    [StockCode]     NVARCHAR (255) NOT NULL,
    [Sku]           NVARCHAR (255) NULL,
    [StockCodeDesc] VARCHAR (255)  NULL,
    [BusinessLine]  NVARCHAR (255) NULL,
    [Category]      NVARCHAR (255) NULL,
    [Cogs]          FLOAT (53)     NULL,
    [ItemName]      VARCHAR (255)  NULL,
    [ItemType]      VARCHAR (50)   NULL,
    [MarketFamily]  VARCHAR (50)   NULL,
    CONSTRAINT [PK_PRODUCT_LINE_GS] PRIMARY KEY CLUSTERED ([StockCode] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT_LINE_GS] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT_LINE_GS] TO [CANDY\srahman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT_LINE_GS] TO [PMData]
    AS [dbo];

