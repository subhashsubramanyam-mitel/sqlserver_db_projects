CREATE TABLE [usage].[temp] (
    [CallDate]         DATE            NULL,
    [LichenAccountid]  BIGINT          NOT NULL,
    [LichenLocationId] BIGINT          NOT NULL,
    [Tn]               NVARCHAR (15)   NOT NULL,
    [CdrServiceTypeId] BIGINT          NOT NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL
);

