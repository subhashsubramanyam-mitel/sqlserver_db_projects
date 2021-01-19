CREATE TABLE [dbo].[B_SFDC_OPP_PRODUCTS] (
    [Id]            VARCHAR (25)  NOT NULL,
    [Currency]      VARCHAR (50)  NULL,
    [MRRConverted]  VARCHAR (50)  NULL,
    [OpportunityId] VARCHAR (25)  NULL,
    [ProductId]     VARCHAR (25)  NULL,
    [Term]          FLOAT (53)    NULL,
    [ProductName]   VARCHAR (255) NULL,
    CONSTRAINT [PK_B_SFDC_OPP_PRODUCTS] PRIMARY KEY CLUSTERED ([Id] ASC)
);

