CREATE TABLE [crimson].[Location] (
    [location_id]         INT            NOT NULL,
    [name]                NVARCHAR (255) NOT NULL,
    [first_name]          NVARCHAR (100) NULL,
    [last_name]           NVARCHAR (100) NULL,
    [email]               NVARCHAR (80)  NULL,
    [phone]               NVARCHAR (40)  NULL,
    [alternate_phone]     NVARCHAR (40)  NULL,
    [tollfree_phone]      NVARCHAR (40)  NULL,
    [fax]                 NVARCHAR (40)  NULL,
    [business_entity_id]  INT            NOT NULL,
    [mail_address_id]     INT            NULL,
    [bill_address_id]     INT            NULL,
    [physical_address_id] INT            NULL,
    [create_user_id]      INT            NOT NULL,
    [create_timestamp]    DATETIME2 (7)  NOT NULL,
    [last_mod_user_id]    INT            NOT NULL,
    [last_mod_timestamp]  DATETIME2 (7)  NOT NULL,
    [delete_user_id]      INT            NULL,
    [delete_timestamp]    DATETIME2 (7)  NULL
);

