CREATE TABLE [rollup].[AccountStats] (
    [Id]                     BIGINT     IDENTITY (1, 1) NOT NULL,
    [AccountId]              INT        NOT NULL,
    [SvcMonth]               DATE       NOT NULL,
    [ClusterId]              INT        NULL,
    [NumCircuits]            INT        CONSTRAINT [DF_AccountStats_NumCircuits] DEFAULT ((0)) NOT NULL,
    [NumProfiles]            INT        CONSTRAINT [DF_AccountStats_NumProfiles] DEFAULT ((0)) NOT NULL,
    [SeatSizeSegmentId]      INT        CONSTRAINT [DF_AccountStats_SeatSizeSegmentId] DEFAULT ((8)) NOT NULL,
    [NumManagedProfiles]     INT        CONSTRAINT [DF_AccountStats_NumManagedProfiles] DEFAULT ((0)) NOT NULL,
    [ProfilePrice]           MONEY      CONSTRAINT [DF_AccountStats_ProfilePrice] DEFAULT ((0)) NOT NULL,
    [ProfilePriceSegmentId]  INT        CONSTRAINT [DF_AccountStats_ProfilePriceSegmentId] DEFAULT ((1)) NOT NULL,
    [NumSupportCasesRegular] INT        CONSTRAINT [DF_AccountStats_NumSupportCasesRegular] DEFAULT ((0)) NOT NULL,
    [NumNocCasesRegular]     INT        CONSTRAINT [DF_AccountStats_NumNocCasesRegular] DEFAULT ((0)) NOT NULL,
    [NumMonthsInvoiced]      INT        CONSTRAINT [DF_AccountStats_NumMonthsInvoiced] DEFAULT ((0)) NOT NULL,
    [IsOlderThan3Months]     BIT        CONSTRAINT [DF_AccountStats_IsOlderThan3Months] DEFAULT ((0)) NOT NULL,
    [PartnerCommissionRate]  FLOAT (53) NULL,
    [HasAccess]              BIT        CONSTRAINT [DF_AccountStats_HasAccess] DEFAULT ((0)) NOT NULL,
    [ProfileCost]            MONEY      CONSTRAINT [DF_AccountStats_ProfileCost] DEFAULT ((0.0)) NOT NULL,
    [ProfileRevenue]         MONEY      CONSTRAINT [DF_AccountStats_ProfileRevenue] DEFAULT ((0)) NOT NULL,
    [AccessCost]             MONEY      CONSTRAINT [DF_AccountStats_Access Cost] DEFAULT ((0)) NOT NULL,
    [AccessRevenue]          MONEY      CONSTRAINT [DF_AccountStats_Access Revenue] DEFAULT ((0)) NOT NULL,
    [ContributionCost]       MONEY      CONSTRAINT [DF_AccountStats_ContributionCost] DEFAULT ((0.0)) NOT NULL,
    [TotalRevenue]           MONEY      CONSTRAINT [DF_AccountStats_ContributionRevenue] DEFAULT ((0)) NOT NULL,
    [GrossCost]              MONEY      CONSTRAINT [DF_AccountStats_GrossCost] DEFAULT ((0)) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170510-100600]
    ON [rollup].[AccountStats]([Id] ASC, [AccountId] ASC, [SvcMonth] ASC);

