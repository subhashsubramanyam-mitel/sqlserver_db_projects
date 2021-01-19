CREATE TABLE [ALSandbox].[ChurnBillSummary] (
    [AccountId]     INT        NOT NULL,
    [DateGenerated] DATE       NOT NULL,
    [MRR]           FLOAT (53) NULL,
    [UsersInvoiced] FLOAT (53) NULL
);

