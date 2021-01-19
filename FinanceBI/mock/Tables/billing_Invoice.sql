CREATE TABLE [mock].[billing_Invoice] (
    [Id]              INT           NOT NULL,
    [DateGenerated]   DATETIME2 (7) NOT NULL,
    [AccountId]       INT           NOT NULL,
    [InvoiceGroupId]  INT           NOT NULL,
    [DatePeriodStart] DATETIME      NOT NULL,
    [DatePeriodEnd]   DATETIME      NOT NULL,
    [LichenInvoiceId] INT           NULL,
    [DateModified]    DATETIME2 (4) NOT NULL,
    [DateCreated]     DATETIME2 (4) NOT NULL,
    [ModifiedBy]      NVARCHAR (50) NOT NULL,
    [CurrencyId]      INT           NOT NULL,
    [CountryId]       INT           NULL
);

