CREATE TABLE [invoice].[AccountMonthlyBillingStats] (
    [AccountId]          INT           NOT NULL,
    [InvoiceMonth]       DATETIME2 (7) NULL,
    [LastInvoiceId]      INT           NULL,
    [NumProfiles]        INT           NULL,
    [NumInvoices]        INT           NULL,
    [NumManagedProfiles] INT           NULL,
    [ClusterId]          INT           NULL,
    [PlatformTypeId]     INT           NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20181222-061800]
    ON [invoice].[AccountMonthlyBillingStats]([InvoiceMonth] ASC);

