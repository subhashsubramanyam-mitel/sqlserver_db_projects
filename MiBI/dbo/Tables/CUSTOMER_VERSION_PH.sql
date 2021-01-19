CREATE TABLE [dbo].[CUSTOMER_VERSION_PH] (
    [SE_ID]       VARCHAR (50) NOT NULL,
    [InstallDate] DATETIME     NULL,
    [Version]     VARCHAR (50) NULL,
    [ST_ID]       VARCHAR (50) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_VERSION_PH] TO [TacEngRole]
    AS [dbo];

