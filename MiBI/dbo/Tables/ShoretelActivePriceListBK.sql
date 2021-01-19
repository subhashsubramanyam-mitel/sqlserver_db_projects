CREATE TABLE [dbo].[ShoretelActivePriceListBK] (
    [SID]       VARCHAR (20) NOT NULL,
    [Pricebook] VARCHAR (10) NULL,
    [SKU]       VARCHAR (50) NULL,
    [PRICE]     VARCHAR (50) NULL,
    CONSTRAINT [PK_ShoreTelActivePricesListBK] PRIMARY KEY CLUSTERED ([SID] ASC)
);

