CREATE TABLE [crimsonEnum].[invoice_structure] (
    [invoice_structure_value] NVARCHAR (255) NOT NULL,
    [description]             NVARCHAR (255) NOT NULL,
    [is_default]              VARCHAR (5)    NOT NULL,
    [display_sequence]        INT            NULL,
    [name]                    NVARCHAR (255) NOT NULL,
    [hidden]                  VARCHAR (5)    NOT NULL
);

