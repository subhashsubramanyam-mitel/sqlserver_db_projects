CREATE TABLE [crimson].[InvoiceLine] (
    [invoice_line_id]                  INT             NOT NULL,
    [invoice_id]                       INT             NOT NULL,
    [price_sheet_product_id]           INT             NOT NULL,
    [service_start_timestamp]          DATETIME2 (7)   NOT NULL,
    [service_end_timestamp]            DATETIME2 (7)   NOT NULL,
    [subtotal]                         NUMERIC (28, 6) NOT NULL,
    [tax]                              NUMERIC (28, 6) NOT NULL,
    [discount]                         NUMERIC (28, 6) NOT NULL,
    [credit]                           NUMERIC (28, 6) NOT NULL,
    [bill_rate]                        NUMERIC (28, 6) NOT NULL,
    [units]                            NUMERIC (28, 6) NOT NULL,
    [usage_charge]                     NUMERIC (28, 6) NULL,
    [fixed_charge]                     NUMERIC (28, 6) NULL,
    [total_amount]                     NUMERIC (28, 6) NOT NULL,
    [discount_rate]                    NUMERIC (28, 6) NULL,
    [prorated]                         VARCHAR (5)     NOT NULL,
    [unit_of_measure_value]            NVARCHAR (255)  NULL,
    [invoice_product_subtotal_id]      INT             NULL,
    [discount_amount]                  NUMERIC (28, 6) NULL,
    [applied_guarantee]                NUMERIC (28, 6) NULL,
    [charge_timestamp]                 DATETIME2 (7)   NULL,
    [charge_description]               NVARCHAR (255)  NULL,
    [tax_exempt_amount]                NUMERIC (28, 6) NOT NULL,
    [create_user_id]                   INT             NOT NULL,
    [create_timestamp]                 DATETIME2 (7)   NOT NULL,
    [last_mod_user_id]                 INT             NOT NULL,
    [last_mod_timestamp]               DATETIME2 (7)   NOT NULL,
    [tax_item_status_value]            NVARCHAR (255)  NOT NULL,
    [current_suretax_response_item_id] INT             NULL,
    [client_order_item_id]             INT             NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194244]
    ON [crimson].[InvoiceLine]([invoice_line_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194300]
    ON [crimson].[InvoiceLine]([last_mod_timestamp] ASC);

