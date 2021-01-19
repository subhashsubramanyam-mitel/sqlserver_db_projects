CREATE TABLE [crimson].[InvoiceLineInventory] (
    [invoice_line_inventory_id]      INT           NOT NULL,
    [invoice_line_id]                INT           NOT NULL,
    [client_order_item_inventory_id] INT           NOT NULL,
    [create_user_id]                 INT           NOT NULL,
    [create_timestamp]               DATETIME2 (7) NOT NULL,
    [delete_user_id]                 INT           NULL,
    [delete_timestamp]               DATETIME2 (7) NULL,
    [last_mod_user_id]               INT           NOT NULL,
    [last_mod_timestamp]             DATETIME2 (7) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194336]
    ON [crimson].[InvoiceLineInventory]([invoice_line_inventory_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194353]
    ON [crimson].[InvoiceLineInventory]([last_mod_timestamp] ASC);

