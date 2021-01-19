CREATE TABLE [dbo].[PricebookEntry_History] (
    [Id]               VARCHAR (50)    NOT NULL,
    [CreatedDate]      DATETIME        NULL,
    [CurrencyIsoCode]  VARCHAR (50)    NULL,
    [EndDate]          DATETIME        NULL,
    [IsActive]         VARCHAR (50)    NULL,
    [LastModifiedDate] DATETIME        NULL,
    [NAME]             VARCHAR (MAX)   NULL,
    [PricebookId]      VARCHAR (50)    NULL,
    [ProductId]        VARCHAR (50)    NULL,
    [SkuNumber]        VARCHAR (50)    NULL,
    [StartDate]        DATETIME        NULL,
    [UnitPrice]        DECIMAL (16, 2) NULL,
    [Current_Flag]     VARCHAR (5)     NULL,
    [Hist_id]          INT             IDENTITY (1, 1) NOT NULL
);

