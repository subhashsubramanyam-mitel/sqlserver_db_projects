CREATE TABLE [enum].[BillingCategory] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [GroupName] NVARCHAR (64)   CONSTRAINT [DF_BillingCategory_GroupName] DEFAULT (N'Unspecified') NOT NULL,
    [Name]      NVARCHAR (1024) NOT NULL,
    CONSTRAINT [PK_BillingCategory] PRIMARY KEY CLUSTERED ([Id] ASC)
);

