CREATE TABLE [invoice].[MonthlyNRR] (
    [InvoiceMonth]          DATE          NOT NULL,
    [InvoiceDay]            DATE          NOT NULL,
    [ServiceId]             INT           NOT NULL,
    [ProdServiceClassId]    INT           NOT NULL,
    [OneTimeCharge]         MONEY         CONSTRAINT [DF_MonthlyNRR_OneTimeCharge] DEFAULT ((0.0)) NOT NULL,
    [LineItemId]            BIGINT        NULL,
    [OrderId]               INT           NULL,
    [AssociatedMRRCategory] NVARCHAR (50) NULL,
    [BookToBillDays]        INT           NULL,
    [ProductId]             INT           NULL,
    [CurrencyId]            INT           CONSTRAINT [DF_MonthlyNRR_CurrencyId] DEFAULT ((1)) NULL
);


GO
CREATE CLUSTERED INDEX [IX_Clustered_InvoiceMonth]
    ON [invoice].[MonthlyNRR]([InvoiceMonth] ASC);

