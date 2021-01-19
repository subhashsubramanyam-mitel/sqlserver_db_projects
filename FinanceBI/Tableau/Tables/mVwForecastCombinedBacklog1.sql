CREATE TABLE [Tableau].[mVwForecastCombinedBacklog1] (
    [Source]        VARCHAR (11)    NOT NULL,
    [Region]        VARCHAR (2)     NOT NULL,
    [Platform]      VARCHAR (16)    NULL,
    [MonthlyCharge] NUMERIC (38, 4) NULL,
    [ForecastDate]  DATE            NULL,
    [OrderStatus]   VARCHAR (50)    NOT NULL,
    [BillingStage]  VARCHAR (50)    NOT NULL,
    [ServiceStatus] VARCHAR (1)     NOT NULL,
    [StallReason]   VARCHAR (2000)  NULL
);

