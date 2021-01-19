CREATE TABLE [invoice].[SPItem] (
    [LineItemId]            INT        NOT NULL,
    [BillingCategoryId]     INT        NOT NULL,
    [ServiceId]             INT        NULL,
    [ProductId]             INT        NULL,
    [InvoiceId]             INT        NOT NULL,
    [DateGenerated]         DATE       NOT NULL,
    [LocationId]            INT        NOT NULL,
    [DatePeriodStart_Local] DATE       NOT NULL,
    [DatePeriodEnd_Local]   DATE       NOT NULL,
    [MonthlyCharge]         MONEY      NULL,
    [OneTimeCharge]         MONEY      NULL,
    [FootnoteNumber]        INT        NULL,
    [MonthsBilled]          FLOAT (53) NULL,
    [InvoiceServiceGroupId] INT        NULL
);


GO
CREATE CLUSTERED INDEX [IX_DateGenerated]
    ON [invoice].[SPItem]([DateGenerated] ASC);

