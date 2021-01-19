CREATE TABLE [rollup].[AccountMetrics] (
    [Id]              BIGINT     IDENTITY (1, 1) NOT NULL,
    [AccountId]       INT        NOT NULL,
    [SvcMonth]        DATE       NOT NULL,
    [ProfileCost]     MONEY      CONSTRAINT [DF_AccountMetrics_ProfileCost] DEFAULT ((0)) NOT NULL,
    [ProfileRevenue]  MONEY      CONSTRAINT [DF_AccountMetrics_ProfileRevenue] DEFAULT ((0)) NOT NULL,
    [ProfileCM]       FLOAT (53) NULL,
    [AccessCost]      MONEY      CONSTRAINT [DF_AccountMetrics_AccessCost] DEFAULT ((0)) NOT NULL,
    [AccessRevenue]   MONEY      CONSTRAINT [DF_AccountMetrics_AccessRevenue] DEFAULT ((0)) NOT NULL,
    [AccessMargin]    FLOAT (53) NULL,
    [GMCost]          MONEY      CONSTRAINT [DF_AccountMetrics_GMCost] DEFAULT ((0)) NOT NULL,
    [GMRevenue]       MONEY      CONSTRAINT [DF_AccountMetrics_GMRevenue] DEFAULT ((0)) NOT NULL,
    [GMProfit]        MONEY      CONSTRAINT [DF_AccountMetrics_GMProfit] DEFAULT ((0)) NOT NULL,
    [GMGM]            FLOAT (53) NULL,
    [CMCost]          MONEY      CONSTRAINT [DF_AccountMetrics_CMCost] DEFAULT ((0)) NOT NULL,
    [CMRevenue]       MONEY      CONSTRAINT [DF_AccountMetrics_CMRevenue] DEFAULT ((0)) NOT NULL,
    [CMProfit]        MONEY      CONSTRAINT [DF_AccountMetrics_CMProfit] DEFAULT ((0)) NOT NULL,
    [CMCM]            FLOAT (53) NULL,
    [CMCategoryId]    INT        NULL,
    [CM3monthAvg]     FLOAT (53) NULL,
    [CMDeviation]     FLOAT (53) NULL,
    [GMminusCM]       FLOAT (53) NULL,
    [IsEligibleForPI] BIT        CONSTRAINT [DF_AccountMetrics_IsEligibleForPI] DEFAULT ((0)) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170510-100751]
    ON [rollup].[AccountMetrics]([Id] ASC, [AccountId] ASC, [SvcMonth] ASC);

