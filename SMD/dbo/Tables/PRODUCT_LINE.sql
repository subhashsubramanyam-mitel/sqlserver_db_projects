CREATE TABLE [dbo].[PRODUCT_LINE] (
    [StockCode]     NVARCHAR (255) NOT NULL,
    [Sku]           NVARCHAR (255) NOT NULL,
    [StockCodeDesc] NVARCHAR (255) NULL,
    [ItemName]      VARCHAR (255)  NULL,
    [BusinessLine]  NVARCHAR (255) NULL,
    [Category]      NVARCHAR (255) NULL,
    [ItemType]      VARCHAR (50)   NULL,
    [MarketFamily]  VARCHAR (50)   NULL,
    [GMFamily]      VARCHAR (50)   NULL,
    CONSTRAINT [PK_PRODUCT_LINE] PRIMARY KEY CLUSTERED ([Sku] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT_LINE] TO [CANDY\BPaddock]
    AS [dbo];

