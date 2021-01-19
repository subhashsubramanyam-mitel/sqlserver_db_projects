CREATE TABLE [invoice].[StateTelecomSurcharge] (
    [AxId]            BIGINT          NOT NULL,
    [LineItemId]      INT             NOT NULL,
    [Charge]          MONEY           NULL,
    [STC]             NUMERIC (22, 6) NULL,
    [InvoiceId]       INT             NOT NULL,
    [LocationId]      INT             NOT NULL,
    [StateId]         INT             NULL,
    [ProductId]       INT             NULL,
    [DatePeriodStart] DATETIME        NOT NULL,
    [DatePeriodEnd]   DATETIME2 (7)   NULL,
    [InvoiceMonth]    DATE            NULL
);

