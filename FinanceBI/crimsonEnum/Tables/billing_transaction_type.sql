﻿CREATE TABLE [crimsonEnum].[billing_transaction_type] (
    [billing_transaction_type_value] NVARCHAR (255) NOT NULL,
    [description]                    NVARCHAR (255) NOT NULL,
    [display_sequence]               INT            NULL,
    [is_default]                     VARCHAR (5)    NOT NULL,
    [name]                           NVARCHAR (255) NOT NULL,
    [hidden]                         VARCHAR (5)    NOT NULL
);

