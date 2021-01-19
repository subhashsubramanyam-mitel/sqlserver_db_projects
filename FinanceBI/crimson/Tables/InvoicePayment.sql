CREATE TABLE [crimson].[InvoicePayment] (
    [invoice_payment_id] INT             NOT NULL,
    [invoice_id]         INT             NOT NULL,
    [payment_timestamp]  DATETIME2 (7)   NOT NULL,
    [amount]             NUMERIC (28, 6) NOT NULL,
    [payment_id]         INT             NOT NULL,
    [attempt]            INT             NOT NULL,
    [refund_amount]      NUMERIC (28, 6) NULL,
    [create_user_id]     INT             NOT NULL,
    [create_timestamp]   DATETIME2 (7)   NOT NULL,
    [last_mod_user_id]   INT             NOT NULL,
    [last_mod_timestamp] DATETIME2 (7)   NOT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194518]
    ON [crimson].[InvoicePayment]([invoice_payment_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194532]
    ON [crimson].[InvoicePayment]([last_mod_timestamp] ASC);

