CREATE TABLE [mock].[billing_InvoiceService] (
    [Id]                     INT           NOT NULL,
    [DateGenerated]          DATETIME2 (4) NOT NULL,
    [InvoiceLineItemId]      INT           NOT NULL,
    [ServiceBillingPeriodId] INT           NOT NULL,
    [ServiceId]              INT           NOT NULL,
    [DateModified]           DATETIME2 (4) NOT NULL,
    [DateCreated]            DATETIME2 (4) NOT NULL,
    [ModifiedBy]             NVARCHAR (50) NOT NULL
);

