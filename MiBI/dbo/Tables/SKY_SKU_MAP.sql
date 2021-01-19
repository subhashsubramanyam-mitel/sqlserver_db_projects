CREATE TABLE [dbo].[SKY_SKU_MAP] (
    [ProductId]    FLOAT (53)   NOT NULL,
    [LichenPlanId] FLOAT (53)   NULL,
    [SKU]          VARCHAR (15) NULL,
    CONSTRAINT [PK_SKY_SKU_MAP] PRIMARY KEY CLUSTERED ([ProductId] ASC)
);

