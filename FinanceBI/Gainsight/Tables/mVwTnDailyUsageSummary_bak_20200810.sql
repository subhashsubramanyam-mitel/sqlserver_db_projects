CREATE TABLE [Gainsight].[mVwTnDailyUsageSummary_bak_20200810] (
    [PortalPersonId]   INT             NULL,
    [PortalPersonName] NVARCHAR (4000) NULL,
    [Is DM]            BIT             NULL,
    [Is PM]            BIT             NULL,
    [Is Billing]       BIT             NULL,
    [Is Technical]     BIT             NULL,
    [PortalAccountId]  INT             NULL,
    [SfdcAccountId]    VARCHAR (18)    COLLATE Latin1_General_BIN NULL,
    [TN]               NVARCHAR (15)   NULL,
    [TnExtension]      VARCHAR (20)    NULL,
    [CallDate]         DATE            NULL,
    [IsIncoming]       INT             NOT NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL
);

