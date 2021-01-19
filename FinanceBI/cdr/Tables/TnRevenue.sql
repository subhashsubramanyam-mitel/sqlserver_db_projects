CREATE TABLE [cdr].[TnRevenue] (
    [Tn]           NVARCHAR (16) NOT NULL,
    [TnTypeId]     INT           NULL,
    [AccountId]    INT           NULL,
    [LocationId]   INT           NULL,
    [MRR]          MONEY         NULL,
    [UsageRevenue] MONEY         NULL,
    [ServiceId]    INT           NULL
);

