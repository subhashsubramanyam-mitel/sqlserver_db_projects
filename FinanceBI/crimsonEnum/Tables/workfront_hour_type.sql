CREATE TABLE [crimsonEnum].[workfront_hour_type] (
    [workfront_hour_type_value] NVARCHAR (255)   NOT NULL,
    [name]                      NVARCHAR (255)   NOT NULL,
    [description]               NVARCHAR (255)   NOT NULL,
    [is_default]                VARCHAR (5)      NOT NULL,
    [display_sequence]          INT              NULL,
    [hidden]                    VARCHAR (5)      NOT NULL,
    [is_billable]               VARCHAR (5)      NOT NULL,
    [product_uuid]              UNIQUEIDENTIFIER NULL
);

