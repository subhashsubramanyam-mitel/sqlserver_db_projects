CREATE TABLE [crimsonEnum].[role] (
    [role]                  NVARCHAR (255) NOT NULL,
    [description]           NVARCHAR (255) NOT NULL,
    [for_vendor]            VARCHAR (5)    NOT NULL,
    [for_client]            VARCHAR (5)    NOT NULL,
    [for_operating_company] VARCHAR (5)    NOT NULL,
    [applies_to]            NVARCHAR (255) NULL,
    [is_default]            VARCHAR (5)    NOT NULL
);

