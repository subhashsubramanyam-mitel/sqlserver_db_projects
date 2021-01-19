CREATE TABLE [invoice].[FUSF] (
    [InvoiceMonth] DATE            NULL,
    [InvoiceId]    INT             NULL,
    [LineItemId]   INT             NULL,
    [ProductId]    INT             NULL,
    [Charge]       DECIMAL (10, 4) NULL,
    [rate]         DECIMAL (6, 4)  NULL,
    [FUSF]         DECIMAL (10, 4) NULL,
    [AxId]         BIGINT          NULL
);

