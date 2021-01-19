CREATE TABLE [dbo].[SFDC_PRODUCTS] (
    [SfdcId]                VARCHAR (20)  COLLATE Latin1_General_BIN NOT NULL,
    [SfdcCreateDateUTC]     DATETIME      NULL,
    [SfdcLastUpdateDateUTC] DATETIME      NULL,
    [SKU]                   VARCHAR (50)  COLLATE Latin1_General_BIN NOT NULL,
    [Name]                  VARCHAR (500) COLLATE Latin1_General_BIN NULL,
    [Description]           VARCHAR (500) COLLATE Latin1_General_BIN NULL,
    [Active]                VARCHAR (10)  COLLATE Latin1_General_BIN NULL,
    [ItemNumber]            VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [ItemDescription]       VARCHAR (500) COLLATE Latin1_General_BIN NULL,
    [GMFamily]              VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [MarketFamily]          VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [ItemType]              VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [SupportItem]           VARCHAR (15)  COLLATE Latin1_General_BIN NULL,
    [SkuLifecycle]          VARCHAR (50)  COLLATE Latin1_General_BIN NULL,
    [ItemGroup]             VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [ItemSubType]           VARCHAR (100) COLLATE Latin1_General_BIN NULL,
    [rn]                    BIGINT        NULL
);

