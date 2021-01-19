CREATE TABLE [dbo].[DiscountsRates] (
    [Id]                VARCHAR (50)  NOT NULL,
    [CreatedDate]       DATETIME      NULL,
    [CommissionRate]    VARCHAR (255) NULL,
    [Currency]          VARCHAR (10)  NULL,
    [CurrentCheckBox]   VARCHAR (10)  NULL,
    [DiscountEndDate]   DATETIME      NULL,
    [DiscountStartDate] DATETIME      NULL,
    [DiscountsRatesId]  VARCHAR (255) NULL,
    [IsCurrent]         VARCHAR (10)  NULL,
    [LastModifiedDate]  DATETIME      NULL,
    [PartnerAccount]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_DiscountsRates] PRIMARY KEY CLUSTERED ([Id] ASC)
);

