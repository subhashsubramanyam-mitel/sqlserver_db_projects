CREATE TABLE [dbo].[OpportunityProduct] (
    [ID]               VARCHAR (50)  NOT NULL,
    [CreatedDate]      DATETIME      NULL,
    [LastModifiedDate] DATETIME      NULL,
    [IsCosmoProduct]   VARCHAR (50)  NULL,
    [MRRListPrice]     VARCHAR (50)  NULL,
    [MRRSales]         VARCHAR (50)  NULL,
    [MRRTotalPrice]    VARCHAR (50)  NULL,
    [NRRExtended]      VARCHAR (50)  NULL,
    [NRRListPrice]     VARCHAR (50)  NULL,
    [NRRSales]         VARCHAR (50)  NULL,
    [NRRTotalPrice]    VARCHAR (50)  NULL,
    [OpportunityID]    VARCHAR (500) NULL,
    [ProductId]        VARCHAR (500) NULL,
    [Quantity]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_OpportunityProduct] PRIMARY KEY CLUSTERED ([ID] ASC)
);

