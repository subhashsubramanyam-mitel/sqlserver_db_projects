CREATE TABLE [usage].[TnDailySummary_Archive] (
    [CallDate]         DATE            NULL,
    [LichenAccountid]  BIGINT          NOT NULL,
    [LichenLocationId] BIGINT          NOT NULL,
    [Tn]               NVARCHAR (15)   NOT NULL,
    [CdrServiceTypeId] BIGINT          NOT NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           FLOAT (53)      NULL,
    [TnExtension]      NVARCHAR (20)   NULL
);


GO
CREATE CLUSTERED INDEX [IX_TN_CallDate_Clustered]
    ON [usage].[TnDailySummary_Archive]([CallDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Account]
    ON [usage].[TnDailySummary_Archive]([LichenAccountid] ASC);


GO
CREATE NONCLUSTERED INDEX [Idx_Location]
    ON [usage].[TnDailySummary_Archive]([LichenLocationId] ASC);

