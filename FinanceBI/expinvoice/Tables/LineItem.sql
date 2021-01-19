CREATE TABLE [expinvoice].[LineItem] (
    [LineItemId]            INT        NOT NULL,
    [BillingCategoryId]     INT        NOT NULL,
    [ProductId]             INT        NULL,
    [InvoiceId]             INT        NOT NULL,
    [DateGenerated]         DATE       NOT NULL,
    [LocationId]            INT        NOT NULL,
    [DatePeriodStart_Local] DATE       NOT NULL,
    [DatePeriodEnd_Local]   DATE       NOT NULL,
    [MonthlyCharge]         MONEY      NULL,
    [OneTimeCharge]         MONEY      NULL,
    [FootnoteNumber]        INT        NULL,
    [Quantity]              FLOAT (53) NULL,
    [InvoiceServiceGroupId] INT        NULL
);


GO
CREATE CLUSTERED INDEX [IX-DateGenerated]
    ON [expinvoice].[LineItem]([DateGenerated] ASC);


GO
CREATE NONCLUSTERED INDEX [IX-InvoiceID]
    ON [expinvoice].[LineItem]([InvoiceId] ASC);

