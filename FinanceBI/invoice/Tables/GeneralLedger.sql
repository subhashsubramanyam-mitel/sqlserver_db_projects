CREATE TABLE [invoice].[GeneralLedger] (
    [SOPType]           SMALLINT        NULL,
    [SOPNumber]         CHAR (21)       NULL,
    [DocId]             CHAR (15)       NULL,
    [CustomerNumber]    CHAR (15)       NULL,
    [BillingAddrCode]   CHAR (15)       NULL,
    [DocDate]           DATETIME        NULL,
    [BatchNumber]       CHAR (15)       NULL,
    [DocAmount]         NUMERIC (19, 5) NULL,
    [SubTotal]          NUMERIC (19, 5) NULL,
    [TaxAmount]         NUMERIC (19, 5) NULL,
    [VoidStatus]        SMALLINT        NULL,
    [InvoiceGroupId]    INT             NULL,
    [InvoiceMonth]      DATE            NOT NULL,
    [InvoiceId]         INT             NULL,
    [DefaultLocationId] INT             NULL
);

