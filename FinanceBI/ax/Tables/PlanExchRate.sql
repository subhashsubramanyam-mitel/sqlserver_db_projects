CREATE TABLE [ax].[PlanExchRate] (
    [Id]           INT          IDENTITY (1, 1) NOT NULL,
    [CurrencyCode] NVARCHAR (3) NOT NULL,
    [DateFrom]     DATE         NOT NULL,
    [DateTo]       DATE         NULL,
    [Rate]         MONEY        NOT NULL
);

