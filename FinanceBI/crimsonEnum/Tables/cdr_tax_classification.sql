CREATE TABLE [crimsonEnum].[cdr_tax_classification] (
    [is_default]                   VARCHAR (5)    NOT NULL,
    [display_sequence]             INT            NULL,
    [name]                         NVARCHAR (255) NOT NULL,
    [hidden]                       VARCHAR (5)    NOT NULL,
    [description]                  NVARCHAR (255) NOT NULL,
    [cdr_tax_classification_value] NVARCHAR (255) NOT NULL
);

