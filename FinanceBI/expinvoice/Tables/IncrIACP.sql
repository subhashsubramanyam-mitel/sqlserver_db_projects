CREATE TABLE [expinvoice].[IncrIACP] (
    [InvoiceDay]         DATETIME      NULL,
    [InvoiceMonth]       DATETIME      NULL,
    [ServiceId]          INT           NULL,
    [ProdServiceClassId] INT           NULL,
    [LastCharge]         MONEY         NULL,
    [CurCharge]          MONEY         NULL,
    [LastLineItemId]     INT           NULL,
    [CurLineItemId]      INT           NULL,
    [Category]           NVARCHAR (32) NULL,
    [MRRDelta]           MONEY         NULL,
    [OrderId]            INT           NULL,
    [LastProductId]      INT           NULL,
    [CurProductId]       INT           NULL,
    [CurrencyId]         INT           CONSTRAINT [DF_IncrIACP_CurrencyId] DEFAULT ((1)) NULL
);


GO
CREATE CLUSTERED INDEX [IX_Clustered_InvoiceMonthyDay]
    ON [expinvoice].[IncrIACP]([InvoiceDay] ASC, [InvoiceMonth] ASC);

