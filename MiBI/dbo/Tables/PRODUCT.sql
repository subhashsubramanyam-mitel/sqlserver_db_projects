CREATE TABLE [dbo].[PRODUCT] (
    [SfdcId]                VARCHAR (20)  NOT NULL,
    [SfdcCreateDateUTC]     DATETIME      NULL,
    [SfdcLastUpdateDateUTC] DATETIME      NULL,
    [SKU]                   VARCHAR (50)  NOT NULL,
    [Name]                  VARCHAR (500) NULL,
    [Description]           VARCHAR (500) NULL,
    [Active]                VARCHAR (10)  NULL,
    [ItemNumber]            VARCHAR (50)  NULL,
    [ItemDescription]       VARCHAR (500) NULL,
    [GMFamily]              VARCHAR (100) NULL,
    [MarketFamily]          VARCHAR (100) NULL,
    [ItemType]              VARCHAR (50)  NULL,
    [SupportItem]           VARCHAR (15)  CONSTRAINT [DF_PRODUCT_SupportItem] DEFAULT ('No') NULL,
    [SkuLifecycle]          VARCHAR (50)  NULL,
    [ItemGroup]             VARCHAR (100) NULL,
    [ItemSubType]           VARCHAR (100) NULL,
    CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PRODUCT_SKU]
    ON [dbo].[PRODUCT]([SKU] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PRODUCT] TO [CANDY\BPaddock]
    AS [dbo];

