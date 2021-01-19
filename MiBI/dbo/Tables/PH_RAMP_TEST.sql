CREATE TABLE [dbo].[PH_RAMP_TEST] (
    [InstallDate]    CHAR (10)    NULL,
    [ProductVersion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CaseCount]      INT          NULL,
    [Defects]        BIGINT       NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PH_RAMP_TEST] TO [CANDY\brobison]
    AS [dbo];

