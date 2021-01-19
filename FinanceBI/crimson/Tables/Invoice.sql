CREATE TABLE [crimson].[Invoice] (
    [invoice_id]                      INT              NOT NULL,
    [client_business_entity_id]       INT              NOT NULL,
    [business_entity_id]              INT              NOT NULL,
    [invoice_timestamp]               DATETIME2 (7)    NULL,
    [generated_timestamp]             DATETIME2 (7)    NULL,
    [prepared_timestamp]              DATETIME2 (7)    NULL,
    [opened_timestamp]                DATETIME2 (7)    NULL,
    [due_date]                        DATE             NULL,
    [total_amount]                    NUMERIC (28, 6)  NOT NULL,
    [address_line1]                   NVARCHAR (255)   NULL,
    [address_line2]                   NVARCHAR (255)   NULL,
    [city]                            NVARCHAR (255)   NULL,
    [state]                           NVARCHAR (255)   NULL,
    [postal_code]                     NVARCHAR (255)   NULL,
    [previous_balance]                NUMERIC (28, 6)  NOT NULL,
    [payments]                        NUMERIC (28, 6)  NOT NULL,
    [adjustments]                     NUMERIC (28, 6)  NOT NULL,
    [current_charges]                 NUMERIC (28, 6)  NOT NULL,
    [invoice_period_start_date]       DATE             NULL,
    [invoice_period_end_date]         DATE             NULL,
    [open_balance]                    NUMERIC (28, 6)  NOT NULL,
    [overpayment]                     NUMERIC (28, 6)  NOT NULL,
    [tax_amount]                      NUMERIC (28, 6)  NOT NULL,
    [pdf_summary]                     VARCHAR (5)      NOT NULL,
    [pdf_detail]                      VARCHAR (5)      NOT NULL,
    [payment_attempts]                INT              NULL,
    [last_reminder_timestamp]         DATETIME2 (7)    NULL,
    [in_collections]                  VARCHAR (5)      NOT NULL,
    [collection_step_value]           NVARCHAR (255)   NULL,
    [invoice_status_value]            NVARCHAR (255)   NOT NULL,
    [tax_exempt_amount]               NUMERIC (28, 6)  NOT NULL,
    [create_user_id]                  INT              NOT NULL,
    [create_timestamp]                DATETIME2 (7)    NOT NULL,
    [last_mod_user_id]                INT              NOT NULL,
    [last_mod_timestamp]              DATETIME2 (7)    NOT NULL,
    [delete_user_id]                  INT              NULL,
    [delete_timestamp]                DATETIME2 (7)    NULL,
    [invoice_batch_id]                INT              NULL,
    [invoice_number]                  INT              NOT NULL,
    [past_due_charges]                NUMERIC (28, 6)  NOT NULL,
    [late_fees]                       NUMERIC (28, 6)  NOT NULL,
    [total_outstanding_charges]       NUMERIC (28, 6)  NOT NULL,
    [total_due]                       NUMERIC (28, 6)  NOT NULL,
    [invoice_uuid]                    UNIQUEIDENTIFIER NOT NULL,
    [sf_record_id]                    NVARCHAR (255)   NULL,
    [sf_last_sync_timestamp]          DATETIME2 (7)    NULL,
    [current_suretax_response_id]     INT              NULL,
    [summary_file_id]                 UNIQUEIDENTIFIER NULL,
    [detail_file_id]                  UNIQUEIDENTIFIER NULL,
    [deliver_timestamp]               DATETIME2 (7)    NULL,
    [business_entity_relationship_id] INT              NULL,
    [country_code_value]              NVARCHAR (255)   NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194134]
    ON [crimson].[Invoice]([invoice_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194210]
    ON [crimson].[Invoice]([last_mod_timestamp] ASC);

