CREATE TABLE [ALSandbox].[ExecKPITargets] (
    [DateCreated]     DATE            NULL,
    [InvoiceMonth]    DATE            NULL,
    [ServiceMonth]    DATE            NULL,
    [Region]          VARCHAR (50)    NULL,
    [KPI]             VARCHAR (50)    NOT NULL,
    [ChildKPI]        VARCHAR (50)    NULL,
    [TargetType]      VARCHAR (50)    NOT NULL,
    [GreenThreshold]  DECIMAL (12, 5) NULL,
    [YellowThreshold] DECIMAL (12, 5) NULL
);

