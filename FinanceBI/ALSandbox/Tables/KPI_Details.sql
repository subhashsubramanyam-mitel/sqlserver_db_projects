CREATE TABLE [ALSandbox].[KPI_Details] (
    [RuthlessPriority]  VARCHAR (21)  NOT NULL,
    [KPI]               VARCHAR (46)  NULL,
    [ValueDesc]         VARCHAR (33)  NOT NULL,
    [Timeframe]         VARCHAR (22)  NOT NULL,
    [KPI_Order]         INT           NULL,
    [RP_Order]          INT           NULL,
    [DashboardURL]      VARCHAR (255) NULL,
    [RegionalView]      VARCHAR (20)  NULL,
    [MetricDescription] VARCHAR (255) NULL,
    [Active]            SMALLINT      NULL,
    [Category_Order]    SMALLINT      NULL,
    [Category]          VARCHAR (50)  NULL,
    [SubCategory_Order] SMALLINT      NULL,
    [SubCategory]       VARCHAR (50)  NULL,
    [FY_Relevant]       VARCHAR (100) NULL,
    [Owner]             VARCHAR (30)  NULL
);

