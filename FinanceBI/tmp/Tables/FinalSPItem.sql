CREATE TABLE [tmp].[FinalSPItem] (
    [LocationId]                  INT             NOT NULL,
    [ServiceId]                   INT             NOT NULL,
    [ProductId]                   INT             NOT NULL,
    [Invoiceid]                   INT             NULL,
    [BillingCategoryId]           INT             NOT NULL,
    [ChargeCategoryId]            INT             NOT NULL,
    [MonthlySubCategoryId]        INT             NULL,
    [ServiceMonth]                DATE            NOT NULL,
    [InvoiceMonth]                DATE            NOT NULL,
    [Charge]                      NUMERIC (20, 4) NULL,
    [OneTimeCharge]               MONEY           NULL,
    [MonthlyCharge]               MONEY           NULL,
    [MRRDeltaForNextServiceMonth] MONEY           NULL,
    [MonthsBilled]                FLOAT (53)      NULL,
    [LineItemCount]               INT             NULL,
    [CCRankAsc]                   INT             NOT NULL,
    [CCRankDesc]                  INT             NOT NULL
);

