CREATE TABLE [invoice].[LocationMonthlyBillingStats] (
    [LocationId]         INT           NOT NULL,
    [InvoiceMonth]       DATETIME2 (7) NULL,
    [LastInvoiceId]      INT           NULL,
    [NumProfiles]        FLOAT (53)    NULL,
    [NumInvoices]        INT           NULL,
    [NumManagedProfiles] INT           NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20181222-072640]
    ON [invoice].[LocationMonthlyBillingStats]([InvoiceMonth] ASC);

