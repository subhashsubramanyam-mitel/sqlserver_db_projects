CREATE TABLE [invoice].[LineItem] (
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
CREATE CLUSTERED INDEX [ClusteredIndex-20151101-221600]
    ON [invoice].[LineItem]([LineItemId] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160101-030907]
    ON [invoice].[LineItem]([InvoiceId] ASC);

