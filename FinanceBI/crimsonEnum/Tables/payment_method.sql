CREATE TABLE [crimsonEnum].[payment_method] (
    [payment_method_value] NVARCHAR (255) NOT NULL,
    [description]          NVARCHAR (255) NOT NULL,
    [is_default]           VARCHAR (5)    NOT NULL,
    [display_sequence]     INT            NULL,
    [for_vendor]           VARCHAR (5)    NOT NULL,
    [name]                 NVARCHAR (255) NULL,
    [hidden]               VARCHAR (5)    NOT NULL
);

