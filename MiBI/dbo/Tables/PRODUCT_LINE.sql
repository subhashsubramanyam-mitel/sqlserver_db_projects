CREATE TABLE [dbo].[PRODUCT_LINE] (
    [StockCode]    VARCHAR (15)  NULL,
    [Part]         VARCHAR (15)  NULL,
    [ProductLine]  VARCHAR (255) NULL,
    [sku]          VARCHAR (15)  NULL,
    [Type]         VARCHAR (15)  NULL,
    [Term]         VARCHAR (50)  NULL,
    [ItemName]     VARCHAR (50)  NULL,
    [ItemType]     VARCHAR (50)  NULL,
    [MarketFamily] VARCHAR (50)  NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT_LINE] TO [CANDY\srahman]
    AS [dbo];

