CREATE TABLE [enum].[Product] (
    [Id]                   INT            NOT NULL,
    [ServiceClassId]       INT            NOT NULL,
    [Name]                 NVARCHAR (128) NOT NULL,
    [ShortName]            NVARCHAR (128) NULL,
    [InvoiceLabel]         NVARCHAR (128) NOT NULL,
    [CatalogOrder]         INT            NULL,
    [IsActive]             BIT            NOT NULL,
    [LichenPlanId]         INT            NULL,
    [DefaultMonthlyCharge] MONEY          NOT NULL,
    [DefaultOneTimeCharge] MONEY          NOT NULL,
    [ProdCategory]         NVARCHAR (50)  CONSTRAINT [DF_Product_ProdCategory] DEFAULT (N'Other') NOT NULL,
    [ProdSubCategory]      NVARCHAR (50)  CONSTRAINT [DF_Product_ProdSubCategory] DEFAULT ('other') NOT NULL,
    [PrimaryHandset]       NVARCHAR (32)  NULL,
    [ProdClassGroup]       NVARCHAR (50)  NULL,
    [RevenueComponent]     NVARCHAR (50)  NULL,
    [IsCrossSellProduct]   BIT            CONSTRAINT [DF_Product_IsCrossSellProduct] DEFAULT ((0)) NOT NULL,
    [RevenueComponentId]   INT            NULL,
    [MRR_SKU]              VARCHAR (18)   NULL,
    [NRR_SKU]              VARCHAR (18)   NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Product_ServiceClass] FOREIGN KEY ([ServiceClassId]) REFERENCES [enum].[ServiceClass] ([Id]) NOT FOR REPLICATION
);


GO
ALTER TABLE [enum].[Product] NOCHECK CONSTRAINT [FK_Product_ServiceClass];

