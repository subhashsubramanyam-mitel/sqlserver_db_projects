CREATE TABLE [company].[Partner] (
    [Id]                INT           NOT NULL,
    [AccountId]         INT           NOT NULL,
    [LichenPartnerId]   INT           NULL,
    [ContractStartDate] DATETIME2 (4) NULL,
    [ContractEndDate]   DATETIME2 (4) NULL,
    [TaxId]             NVARCHAR (20) NULL,
    [IsTerminated]      BIT           NULL,
    [DateModified]      DATETIME2 (4) NOT NULL,
    [DateCreated]       DATETIME2 (4) NOT NULL,
    [ModifiedBy]        NVARCHAR (50) NOT NULL
);

