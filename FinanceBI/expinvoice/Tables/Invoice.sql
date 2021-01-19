CREATE TABLE [expinvoice].[Invoice] (
    [Id]                    INT  NOT NULL,
    [DateGenerated]         DATE NOT NULL,
    [AccountId]             INT  NOT NULL,
    [InvoiceGroupId]        INT  NOT NULL,
    [DatePeriodStart_Local] DATE NOT NULL,
    [DatePeriodEnd_Local]   DATE NOT NULL,
    [LichenInvoiceId]       INT  NULL,
    [CurrencyId]            INT  CONSTRAINT [DF_Invoice_CurrencyId] DEFAULT ((1)) NOT NULL
);

