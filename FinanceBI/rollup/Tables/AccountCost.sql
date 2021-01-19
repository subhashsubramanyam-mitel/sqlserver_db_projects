CREATE TABLE [rollup].[AccountCost] (
    [Id]              BIGINT IDENTITY (1, 1) NOT NULL,
    [AccountId]       INT    NOT NULL,
    [SvcMonth]        DATE   NOT NULL,
    [CostComponentId] INT    NOT NULL,
    [Cost]            MONEY  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170510-100825]
    ON [rollup].[AccountCost]([Id] ASC, [AccountId] ASC, [SvcMonth] ASC);

