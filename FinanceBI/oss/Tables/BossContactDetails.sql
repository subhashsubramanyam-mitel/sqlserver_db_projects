CREATE TABLE [oss].[BossContactDetails] (
    [Region]        VARCHAR (2)    NOT NULL,
    [TN]            VARCHAR (15)   NOT NULL,
    [Customer Name] NVARCHAR (120) NULL,
    [Platform]      VARCHAR (25)   NULL,
    [Account Team]  NVARCHAR (32)  NULL,
    [Instance]      NCHAR (100)    NULL,
    CONSTRAINT [PK_oss_BossContactDetails] PRIMARY KEY CLUSTERED ([Region] ASC, [TN] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[oss].[BossContactDetails] TO [app_MiCC]
    AS [dbo];

