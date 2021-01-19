CREATE TABLE [ALSandbox].[KPI_CorvBillings] (
    [ServiceMonth] DATE           NOT NULL,
    [Billings]     DECIMAL (9, 2) NULL,
    PRIMARY KEY CLUSTERED ([ServiceMonth] ASC)
);

