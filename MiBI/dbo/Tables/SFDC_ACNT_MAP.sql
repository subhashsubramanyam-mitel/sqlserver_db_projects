CREATE TABLE [dbo].[SFDC_ACNT_MAP] (
    [SFDC_ID] VARCHAR (50) NULL,
    [SE_ID]   VARCHAR (50) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SFDC_ACNT_MAP] TO [Marketing]
    AS [dbo];

