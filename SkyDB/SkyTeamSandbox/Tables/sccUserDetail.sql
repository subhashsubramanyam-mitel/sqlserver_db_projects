CREATE TABLE [SkyTeamSandbox].[sccUserDetail] (
    [instance]   VARCHAR (MAX) NULL,
    [tenant]     VARCHAR (MAX) NULL,
    [username]   VARCHAR (MAX) NULL,
    [active]     INT           NULL,
    [agent]      INT           NULL,
    [supervisor] INT           NULL,
    [role_list]  VARCHAR (MAX) NULL
);


GO
GRANT SELECT
    ON OBJECT::[SkyTeamSandbox].[sccUserDetail] TO [app_Sky_ro]
    AS [app_skydb];

