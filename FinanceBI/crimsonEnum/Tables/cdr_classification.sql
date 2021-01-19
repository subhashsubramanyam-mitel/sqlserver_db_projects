CREATE TABLE [crimsonEnum].[cdr_classification] (
    [is_default]               VARCHAR (5)    NOT NULL,
    [display_sequence]         INT            NULL,
    [cdr_classification_value] NVARCHAR (255) NOT NULL,
    [name]                     NVARCHAR (255) NOT NULL,
    [description]              NVARCHAR (255) NOT NULL,
    [hidden]                   VARCHAR (5)    NOT NULL
);

