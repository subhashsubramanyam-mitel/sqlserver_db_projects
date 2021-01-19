CREATE TABLE [rollup].[AccountRevenue] (
    [Id]                 BIGINT IDENTITY (1, 1) NOT NULL,
    [AccountId]          INT    NOT NULL,
    [SvcMonth]           DATE   NOT NULL,
    [RevenueComponentId] INT    CONSTRAINT [DF_AccountBilling_Usage] DEFAULT ((0)) NOT NULL,
    [Quantity]           INT    NULL,
    [Revenue]            MONEY  CONSTRAINT [DF_AccountBilling_Profile] DEFAULT ((0)) NOT NULL,
    [ProductId]          INT    NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170510-100702]
    ON [rollup].[AccountRevenue]([Id] ASC, [AccountId] ASC, [SvcMonth] ASC);

