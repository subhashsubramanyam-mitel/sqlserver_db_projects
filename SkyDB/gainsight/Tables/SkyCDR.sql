CREATE TABLE [gainsight].[SkyCDR] (
    [ServiceMonth]     DATE            NULL,
    [Accountid]        INT             NULL,
    [LocationId]       INT             NULL,
    [ProfileId]        INT             NULL,
    [PersonId]         INT             NULL,
    [TN]               VARCHAR (64)    NULL,
    [TnExtension]      VARCHAR (20)    NULL,
    [CdrServiceTypeId] SMALLINT        NULL,
    [CdrCallTypeId]    SMALLINT        NULL,
    [CdrRegionTypeId]  SMALLINT        NULL,
    [ClusterId]        INT             NULL,
    [NumCalls]         INT             NULL,
    [Minutes]          NUMERIC (38, 6) NULL,
    [Charge]           NUMERIC (38, 9) NULL
);


GO
GRANT DELETE
    ON OBJECT::[gainsight].[SkyCDR] TO [app_megasilo]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[gainsight].[SkyCDR] TO [app_megasilo]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[gainsight].[SkyCDR] TO [app_megasilo]
    AS [dbo];

