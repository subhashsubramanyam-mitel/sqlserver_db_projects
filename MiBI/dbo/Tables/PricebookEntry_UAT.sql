CREATE TABLE [dbo].[PricebookEntry_UAT] (
    [Id]               VARCHAR (50)    NOT NULL,
    [CreatedDate]      DATETIME        NULL,
    [CurrencyIsoCode]  VARCHAR (50)    NULL,
    [EndDate]          DATETIME        NULL,
    [IsActive]         VARCHAR (50)    NULL,
    [LastModifiedDate] DATETIME        NULL,
    [NAME]             VARCHAR (MAX)   NULL,
    [PricebookId]      VARCHAR (50)    NULL,
    [PricebookName]    VARCHAR (255)   NULL,
    [ProductId]        VARCHAR (50)    NULL,
    [SkuNumber]        VARCHAR (50)    NULL,
    [StartDate]        DATETIME        NULL,
    [UnitPrice]        DECIMAL (16, 2) NULL,
    CONSTRAINT [PK_PricebookEntry_UAT] PRIMARY KEY CLUSTERED ([Id] ASC)
);

