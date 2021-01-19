CREATE TABLE [crimsonEnum].[order_type] (
    [is_default]       VARCHAR (5)    NOT NULL,
    [order_type_value] NVARCHAR (255) NOT NULL,
    [display_sequence] INT            NULL,
    [name]             NVARCHAR (255) NOT NULL,
    [hidden]           VARCHAR (5)    NOT NULL,
    [description]      NVARCHAR (255) NOT NULL
);

