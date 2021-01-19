CREATE TABLE [usage].[TnDailySummary_Sky] (
    [CallDate]         DATE            NULL,
    [LichenAccountid]  BIGINT          NOT NULL,
    [LichenLocationId] BIGINT          NOT NULL,
    [ProfileId]        INT             NULL,
    [Tn]               VARCHAR (64)    NOT NULL,
    [TnExtension]      VARCHAR (20)    NULL,
    [CdrServiceTypeId] BIGINT          NOT NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL
);

