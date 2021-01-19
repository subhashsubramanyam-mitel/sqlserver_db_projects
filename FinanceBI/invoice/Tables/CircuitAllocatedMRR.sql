CREATE TABLE [invoice].[CircuitAllocatedMRR] (
    [InvoiceMonth]           DATE           NOT NULL,
    [ServiceId]              INT            NOT NULL,
    [ServiceBillingPeriodId] INT            NOT NULL,
    [ProductId]              INT            NULL,
    [DateTo]                 DATE           NULL,
    [WTN]                    NVARCHAR (128) NULL,
    [AltWTN]                 NVARCHAR (128) NULL,
    [OrigMRR]                MONEY          NULL,
    [AllocatedMRR]           MONEY          NULL,
    [Companyid]              INT            NULL,
    [AccountId]              INT            NULL,
    [LocationId]             INT            NULL
);

