CREATE TABLE [Tableau].[mVwForecastCombinedBacklog2] (
    [Source]        VARCHAR (6)     NOT NULL,
    [Region]        VARCHAR (2)     NOT NULL,
    [Platform]      VARCHAR (7)     NOT NULL,
    [MonthlyCharge] NUMERIC (38, 6) NULL,
    [ForecastDate]  DATE            NULL,
    [OrderStatus]   NVARCHAR (20)   NULL,
    [BillingStage]  VARCHAR (17)    NULL,
    [ServiceStatus] NVARCHAR (128)  NULL,
    [StallReason]   INT             NULL
);

