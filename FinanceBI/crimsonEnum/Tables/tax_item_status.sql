CREATE TABLE [crimsonEnum].[tax_item_status] (
    [is_default]            VARCHAR (5)    NOT NULL,
    [display_sequence]      INT            NULL,
    [name]                  NVARCHAR (255) NOT NULL,
    [tax_item_status_value] NVARCHAR (255) NOT NULL,
    [description]           NVARCHAR (255) NOT NULL,
    [hidden]                VARCHAR (5)    NOT NULL
);

