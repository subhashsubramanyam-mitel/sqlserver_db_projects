CREATE TABLE [audit].[mVwTnMonthlyUsageSummary] (
    [AccountId]    INT           NULL,
    [TN]           NVARCHAR (15) NULL,
    [ServiceMonth] DATE          NULL,
    [TotalCalls]   INT           NULL,
    [TotalMinutes] MONEY         NULL,
    [TotalCharge]  MONEY         NULL,
    [InCalls]      INT           NULL,
    [InMinutes]    MONEY         NULL,
    [InCharge]     MONEY         NULL,
    [OutCalls]     INT           NULL,
    [OutMinutes]   MONEY         NULL,
    [OutCharge]    MONEY         NULL,
    [ServiceId]    INT           NULL,
    [InVolume]     NVARCHAR (12) NULL,
    [OutVolume]    NVARCHAR (12) NULL,
    [TotalVolume]  NVARCHAR (12) NULL,
    [InUse]        BIT           NULL
);

