CREATE TABLE [crimson].[InvoiceLineTaxGroup] (
    [invoice_line_tax_group_id]        INT             NOT NULL,
    [invoice_line_id]                  INT             NOT NULL,
    [bill_rate]                        NUMERIC (28, 6) NOT NULL,
    [units]                            NUMERIC (28, 6) NOT NULL,
    [subtotal]                         NUMERIC (28, 6) NOT NULL,
    [service_address_zip]              NVARCHAR (255)  NOT NULL,
    [current_suretax_response_item_id] INT             NULL,
    [create_user_id]                   INT             NOT NULL,
    [create_timestamp]                 DATETIME2 (7)   NOT NULL,
    [last_mod_user_id]                 INT             NOT NULL,
    [last_mod_timestamp]               DATETIME2 (7)   NOT NULL,
    [delete_user_id]                   INT             NULL,
    [delete_timestamp]                 DATETIME2 (7)   NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194435]
    ON [crimson].[InvoiceLineTaxGroup]([invoice_line_tax_group_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194458]
    ON [crimson].[InvoiceLineTaxGroup]([last_mod_timestamp] ASC);

