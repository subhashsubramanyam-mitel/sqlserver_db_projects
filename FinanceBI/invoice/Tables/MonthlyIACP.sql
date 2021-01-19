CREATE TABLE [invoice].[MonthlyIACP] (
    [InvoiceMonth]       DATE          NULL,
    [ServiceId]          INT           NULL,
    [ProdServiceClassId] INT           NULL,
    [LastCharge]         MONEY         NULL,
    [CurCharge]          MONEY         NULL,
    [LastLineItemId]     INT           NULL,
    [CurLineItemId]      INT           NULL,
    [Category]           NVARCHAR (32) NULL,
    [MRRDelta]           MONEY         NULL,
    [OrderId]            INT           NULL,
    [InvoiceDay]         DATE          NULL,
    [LastProductId]      INT           NULL,
    [CurProductId]       INT           NULL,
    [CurrencyId]         INT           CONSTRAINT [DF_MonthlyIACP_CurrencyId] DEFAULT ((1)) NULL
);


GO
CREATE CLUSTERED INDEX [IX_Clustered_InvoiceMonth]
    ON [invoice].[MonthlyIACP]([InvoiceMonth] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ServiceId_AddedCols]
    ON [invoice].[MonthlyIACP]([ServiceId] ASC)
    INCLUDE([InvoiceMonth], [Category], [LastProductId], [CurProductId]);

