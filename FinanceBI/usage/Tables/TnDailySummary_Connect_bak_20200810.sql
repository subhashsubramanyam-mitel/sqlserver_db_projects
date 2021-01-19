CREATE TABLE [usage].[TnDailySummary_Connect_bak_20200810] (
    [CallDate]         DATE            NULL,
    [Accountid]        BIGINT          NOT NULL,
    [LocationId]       BIGINT          NOT NULL,
    [ProfileId]        INT             NULL,
    [PersonId]         INT             NULL,
    [Tn]               VARCHAR (64)    NOT NULL,
    [TnExtension]      VARCHAR (20)    NULL,
    [CdrServiceTypeId] BIGINT          NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL
);

