CREATE TABLE [dbo].[ShoretelActivePriceList2] (
    [SKUNumber] VARCHAR (10) NOT NULL,
    [USPrice]   VARCHAR (50) NULL,
    [UKPrice]   VARCHAR (50) NULL,
    [EUPrice]   VARCHAR (50) NULL,
    [AUPrice]   VARCHAR (50) NULL,
    [CAPrice]   VARCHAR (50) NULL,
    [USD]       VARCHAR (50) NULL,
    [GBP]       VARCHAR (50) NULL,
    [EUR]       VARCHAR (50) NULL,
    [AUD]       VARCHAR (50) NULL,
    [CAD]       VARCHAR (50) NULL,
    CONSTRAINT [PK_ShoretelActivePriceList2] PRIMARY KEY CLUSTERED ([SKUNumber] ASC)
);

