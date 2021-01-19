CREATE TABLE [crimsonEnum].[state] (
    [state_abbrev] NVARCHAR (2)   NOT NULL,
    [name]         NVARCHAR (255) NOT NULL,
    [state_fips]   NVARCHAR (255) NULL,
    [is_default]   VARCHAR (5)    NOT NULL
);

