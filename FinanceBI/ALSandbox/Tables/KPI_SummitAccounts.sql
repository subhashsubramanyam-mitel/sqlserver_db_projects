CREATE TABLE [ALSandbox].[KPI_SummitAccounts] (
    [ServiceMonth] DATE         NOT NULL,
    [AcSize]       VARCHAR (50) NOT NULL,
    [Qty]          INT          NULL,
    CONSTRAINT [PK_SummitAccounts] PRIMARY KEY CLUSTERED ([ServiceMonth] ASC, [AcSize] ASC)
);

