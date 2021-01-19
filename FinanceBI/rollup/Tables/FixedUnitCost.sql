CREATE TABLE [rollup].[FixedUnitCost] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [ProdCategory]      NVARCHAR (64) NOT NULL,
    [ProdSubCategory]   NVARCHAR (64) NOT NULL,
    [ProdClassLeafName] NVARCHAR (64) NOT NULL,
    [PrimaryHandset]    NVARCHAR (50) NULL,
    [SvcMonth]          DATE          NULL,
    [Cost]              MONEY         NOT NULL,
    CONSTRAINT [PK_FixedUnitCosts] PRIMARY KEY CLUSTERED ([Id] ASC)
);

