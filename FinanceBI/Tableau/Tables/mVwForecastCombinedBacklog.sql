CREATE TABLE [Tableau].[mVwForecastCombinedBacklog] (
    [Source]         VARCHAR (11)    NOT NULL,
    [Region]         VARCHAR (2)     NOT NULL,
    [ActivationType] NVARCHAR (50)   NULL,
    [Platform]       VARCHAR (5)     NOT NULL,
    [MonthlyCharge]  NUMERIC (38, 4) NULL,
    [ForecastDate]   DATE            NULL,
    [OrderStatus]    NVARCHAR (50)   NULL,
    [BillingStage]   VARCHAR (50)    NULL,
    [ServiceStatus]  NVARCHAR (128)  NULL,
    [StallReason]    VARCHAR (2000)  NULL,
    [InstallOrAdd]   VARCHAR (7)     NOT NULL,
    [isStalled]      INT             NOT NULL,
    [PM]             NVARCHAR (2000) NULL,
    [OrderNumber]    INT             NULL,
    [Account]        NVARCHAR (120)  NULL
);

