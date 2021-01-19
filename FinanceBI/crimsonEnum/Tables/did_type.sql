CREATE TABLE [crimsonEnum].[did_type] (
    [is_default]       VARCHAR (5)    NOT NULL,
    [display_sequence] INT            NULL,
    [did_type_value]   NVARCHAR (255) NOT NULL,
    [name]             NVARCHAR (255) NOT NULL,
    [hidden]           VARCHAR (5)    NOT NULL,
    [description]      NVARCHAR (255) NOT NULL
);

