CREATE TABLE [rollup].[FixedCommonCost] (
    [Id]                  INT   IDENTITY (1, 1) NOT NULL,
    [FixedCostCategoryId] INT   NOT NULL,
    [SvcMonth]            DATE  NULL,
    [Cost]                MONEY NOT NULL,
    CONSTRAINT [PK_CommonCosts] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170510-100117]
    ON [rollup].[FixedCommonCost]([SvcMonth] ASC, [FixedCostCategoryId] ASC);

