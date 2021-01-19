CREATE TABLE [dbo].[SHOR_BUILD_MAPPING] (
    [Object]      NVARCHAR (255) NULL,
    [Build]       NVARCHAR (255) NULL,
    [FirstWeekCR] DATETIME       NULL,
    [FirstWeekGA] DATETIME       NULL,
    [Version]     NVARCHAR (255) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SHOR_BUILD_MAPPING] TO [CANDY\brobison]
    AS [dbo];

