CREATE TABLE [crimsonEnum].[charging_model] (
    [charging_model_value] NVARCHAR (255) NOT NULL,
    [description]          NVARCHAR (255) NOT NULL,
    [display_sequence]     INT            NULL,
    [is_default]           VARCHAR (5)    NOT NULL,
    [name]                 NVARCHAR (255) NOT NULL,
    [hidden]               VARCHAR (5)    NOT NULL
);

