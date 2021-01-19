CREATE TABLE [mcss].[AccountProductProfileSummary] (
    [AccountId]            INT             NULL,
    [LocationId]           INT             NULL,
    [ContractId]           INT             NULL,
    [ProductId]            INT             NULL,
    [MRR]                  NUMERIC (19, 4) NULL,
    [NRR]                  NUMERIC (19, 4) NULL,
    [WaiveNRR]             INT             NULL,
    [ContractQty]          INT             NULL,
    [ProvQty]              INT             NULL,
    [RemainingQty]         INT             NULL,
    [AllocatedPendingQty]  INT             NOT NULL,
    [AutoProvisioningRank] BIGINT          NULL
);

