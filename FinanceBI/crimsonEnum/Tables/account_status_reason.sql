CREATE TABLE [crimsonEnum].[account_status_reason] (
    [is_default]                  VARCHAR (5)    NOT NULL,
    [account_status_reason_value] NVARCHAR (255) NOT NULL,
    [display_sequence]            INT            NULL,
    [name]                        NVARCHAR (255) NOT NULL,
    [hidden]                      VARCHAR (5)    NOT NULL,
    [description]                 NVARCHAR (255) NOT NULL
);

