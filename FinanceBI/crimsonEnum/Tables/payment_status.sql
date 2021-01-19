CREATE TABLE [crimsonEnum].[payment_status] (
    [payment_status_value] NVARCHAR (255) NOT NULL,
    [description]          NVARCHAR (255) NOT NULL,
    [is_default]           VARCHAR (5)    NOT NULL,
    [display_sequence]     INT            NULL,
    [for_electronic]       VARCHAR (5)    NOT NULL,
    [for_external]         VARCHAR (5)    NOT NULL,
    [for_refund]           VARCHAR (5)    NOT NULL,
    [name]                 NVARCHAR (255) NULL
);

