CREATE TABLE [dbo].[SFDC_OPP_PRODUCTS] (
    [Created]       DATETIME      CONSTRAINT [DF_SFDC_OPP_PRODUCTS_Created] DEFAULT (getdate()) NULL,
    [Id]            VARCHAR (25)  NOT NULL,
    [OpportunityId] VARCHAR (25)  NULL,
    [ProductName]   VARCHAR (255) NULL,
    [SKU]           VARCHAR (50)  NULL,
    [USPrice]       FLOAT (53)    NULL,
    [ProductId]     VARCHAR (25)  NULL,
    [Qty]           FLOAT (53)    NULL,
    [NRRTotal]      FLOAT (53)    NULL,
    [NRRList]       FLOAT (53)    NULL,
    [NRRSales]      FLOAT (53)    NULL,
    [isDeleted]     INT           CONSTRAINT [DF_SFDC_OPP_PRODUCTS_isDeleted] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SFDC_OPP_PRODUCTS] PRIMARY KEY CLUSTERED ([Id] ASC)
);

