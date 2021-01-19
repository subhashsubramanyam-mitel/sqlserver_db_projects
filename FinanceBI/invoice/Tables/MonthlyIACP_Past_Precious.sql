CREATE TABLE [invoice].[MonthlyIACP_Past_Precious] (
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
    [CurrencyId]         INT           NULL
);

