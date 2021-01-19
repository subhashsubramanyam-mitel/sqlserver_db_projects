CREATE TABLE [usage].[TNSummary] (
    [AccountId]        INT             NULL,
    [LichenAccountid]  BIGINT          NULL,
    [LocationId]       INT             NULL,
    [LichenLocationId] BIGINT          NULL,
    [Tn]               NVARCHAR (15)   NOT NULL,
    [CdrCallTypeid]    BIGINT          NULL,
    [CdrServiceTypeId] BIGINT          NOT NULL,
    [CdrRegionTypeId]  BIGINT          NOT NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL,
    [ServiceMonth]     DATE            NOT NULL
);

