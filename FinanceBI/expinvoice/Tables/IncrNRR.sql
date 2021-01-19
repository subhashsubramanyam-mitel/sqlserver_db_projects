CREATE TABLE [expinvoice].[IncrNRR] (
    [InvoiceMonth]          DATE          NOT NULL,
    [InvoiceDay]            DATE          NOT NULL,
    [ServiceId]             INT           NOT NULL,
    [ProdServiceClassId]    INT           NOT NULL,
    [OneTimeCharge]         MONEY         NOT NULL,
    [LineItemId]            BIGINT        NULL,
    [OrderId]               INT           NULL,
    [AssociatedMRRCategory] NVARCHAR (50) NULL,
    [BookToBillDays]        INT           NULL,
    [ProductId]             INT           NULL,
    [CurrencyId]            INT           CONSTRAINT [DF_IncrNRR_CurrencyId] DEFAULT ((1)) NULL
);


GO
CREATE CLUSTERED INDEX [IX_Clustered_InvoiceMonthDay]
    ON [expinvoice].[IncrNRR]([InvoiceMonth] ASC, [InvoiceDay] ASC);

