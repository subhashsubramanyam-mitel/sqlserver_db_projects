CREATE TABLE [enum].[VendorHLCostCategory] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [PrefixPattern] NVARCHAR (128) NOT NULL,
    [CostCategory]  NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_VendorHLCostCategory] PRIMARY KEY CLUSTERED ([Id] ASC)
);

