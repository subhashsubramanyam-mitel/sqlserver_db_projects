CREATE TABLE [rollup].[TmpAccountStats] (
    [IsNeeded]               BIT        CONSTRAINT [DF_TmpAccountStats_IsNeeded] DEFAULT ((0)) NOT NULL,
    [AccountId]              INT        NOT NULL,
    [SvcMonth]               DATE       NOT NULL,
    [ClusterId]              INT        NULL,
    [NumCircuits]            INT        CONSTRAINT [DF_TmpAccountStats_NumCircuits] DEFAULT ((0)) NOT NULL,
    [NumProfiles]            INT        CONSTRAINT [DF_TmpAccountStats_NumProfiles] DEFAULT ((0)) NOT NULL,
    [SeatSizeSegmentId]      INT        CONSTRAINT [DF_TmpAccountStats_SeatSizeSegmentId] DEFAULT ((8)) NOT NULL,
    [NumManagedProfiles]     INT        CONSTRAINT [DF_TmpAccountStats_NumManagedProfiles] DEFAULT ((0)) NOT NULL,
    [ProfilePrice]           MONEY      CONSTRAINT [DF_TmpAccountStats_ProfilePrice] DEFAULT ((0.0)) NOT NULL,
    [ProfilePriceSegmentId]  INT        CONSTRAINT [DF_TmpAccountStats_ProfilePriceSegmentId] DEFAULT ((1)) NOT NULL,
    [NumSupportCasesRegular] INT        CONSTRAINT [DF_TmpAccountStats_NumSupportCasesRegular] DEFAULT ((0)) NOT NULL,
    [NumNocCasesRegular]     INT        CONSTRAINT [DF_TmpAccountStats_NumNocCasesRegular] DEFAULT ((0)) NOT NULL,
    [NumMonthsInvoiced]      INT        CONSTRAINT [DF_TmpAccountStats_NumMonthsInvoiced] DEFAULT ((0)) NOT NULL,
    [IsOlderThan3Months]     BIT        CONSTRAINT [DF_TmpAccountStats_IsOlderThan3Months] DEFAULT ((0)) NOT NULL,
    [PartnerCommissionRate]  FLOAT (53) NULL,
    [HasAccess]              BIT        CONSTRAINT [DF_TmpAccountStats_HasAccess] DEFAULT ((0)) NOT NULL,
    [ProfileCost]            MONEY      CONSTRAINT [DF_TmpAccountStats_ProfileCost] DEFAULT ((0)) NOT NULL,
    [ProfileRevenue]         MONEY      CONSTRAINT [DF_TmpAccountStats_ProfileRevenue] DEFAULT ((0)) NOT NULL,
    [AccessCost]             MONEY      CONSTRAINT [DF_TmpAccountStats_AccessCost] DEFAULT ((0)) NOT NULL,
    [AccessRevenue]          MONEY      CONSTRAINT [DF_TmpAccountStats_AccessRevenue] DEFAULT ((0)) NOT NULL,
    [ContributionCost]       MONEY      CONSTRAINT [DF_TmpAccountStats_ContributionCost] DEFAULT ((0)) NOT NULL,
    [TotalRevenue]           MONEY      CONSTRAINT [DF_TmpAccountStats_TotalRevenue] DEFAULT ((0)) NOT NULL,
    [GrossCost]              MONEY      CONSTRAINT [DF_TmpAccountStats_GrossCost] DEFAULT ((0)) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170510-100335]
    ON [rollup].[TmpAccountStats]([AccountId] ASC, [SvcMonth] ASC);


GO
CREATE TRIGGER [rollup].[TG_UpdateAccountStats]
 ON [rollup].[TmpAccountStats]
AFTER UPDATE
AS
BEGIN

	update 
		c
	set
		c.IsNeeded = 1
	from
		rollup.TmpAccountStats c inner join deleted d
			on c.AccountId = d.AccountId and c.SvcMonth = d.SvcMonth
	where c.NumCircuits <> d.NumCircuits or
		c.NumProfiles <> d.NumProfiles 

END

