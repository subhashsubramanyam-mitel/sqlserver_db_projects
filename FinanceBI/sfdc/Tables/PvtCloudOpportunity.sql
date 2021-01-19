CREATE TABLE [sfdc].[PvtCloudOpportunity] (
    [SalesPerson]       NVARCHAR (128) NULL,
    [Opportunity]       NVARCHAR (128) NULL,
    [Type]              NVARCHAR (64)  NULL,
    [Probability]       FLOAT (53)     NULL,
    [AT&T Contact]      NVARCHAR (128) NULL,
    [Status]            NVARCHAR (64)  NULL,
    [UC Standard]       MONEY          NULL,
    [UC Enhanced]       MONEY          NULL,
    [ECC Standard]      MONEY          NULL,
    [Total Monthly Rev] MONEY          NULL,
    [Stage]             NVARCHAR (32)  NULL,
    [Date]              DATE           NULL
);

