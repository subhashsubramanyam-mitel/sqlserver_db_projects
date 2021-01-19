CREATE TABLE [dbo].[ShoretelActivePriceList] (
    [SID]       VARCHAR (20) NOT NULL,
    [Pricebook] VARCHAR (10) NULL,
    [SKU]       VARCHAR (50) NULL,
    [PRICE]     VARCHAR (50) NULL,
    CONSTRAINT [PK_ShoretelActivePriceList] PRIMARY KEY CLUSTERED ([SID] ASC)
);

