CREATE TABLE [dbo].[Pricebook_Temp] (
    [Id]                   VARCHAR (50)   NOT NULL,
    [Name]                 VARCHAR (8000) NULL,
    [SKU]                  VARCHAR (8000) NULL,
    [IsActive]             VARCHAR (8000) NULL,
    [PricebookEntryStatus] VARCHAR (8000) NULL,
    [Status]               VARCHAR (50)   NULL,
    [Error]                VARCHAR (MAX)  NULL,
    [IdFromSKU]            VARCHAR (50)   NULL,
    [Status2]              VARCHAR (50)   NULL,
    [Error2]               VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_Pricebook_Temp] PRIMARY KEY CLUSTERED ([Id] ASC)
);

