CREATE TABLE [enum].[OrderType] (
    [Id]   INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DimOrderType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

