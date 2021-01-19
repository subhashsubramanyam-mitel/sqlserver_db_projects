CREATE TABLE [crimson].[InvoiceTaxLine] (
    [invoice_tax_line_id]       INT             NOT NULL,
    [invoice_line_id]           INT             NOT NULL,
    [tax_rate]                  NUMERIC (28, 6) NOT NULL,
    [tax_type_code]             NVARCHAR (255)  NOT NULL,
    [tax_type_description]      NVARCHAR (255)  NOT NULL,
    [tax_amount]                NUMERIC (28, 6) NOT NULL,
    [revenue]                   NUMERIC (28, 6) NOT NULL,
    [state_abbrev]              NVARCHAR (255)  NOT NULL,
    [county]                    NVARCHAR (255)  NOT NULL,
    [city]                      NVARCHAR (255)  NOT NULL,
    [zipcode]                   NVARCHAR (255)  NOT NULL,
    [plus_four]                 NVARCHAR (255)  NULL,
    [create_user_id]            INT             NOT NULL,
    [create_timestamp]          DATETIME2 (7)   NOT NULL,
    [last_mod_user_id]          INT             NOT NULL,
    [last_mod_timestamp]        DATETIME2 (7)   NOT NULL,
    [delete_user_id]            INT             NULL,
    [delete_timestamp]          DATETIME2 (7)   NULL,
    [percent_taxable]           NUMERIC (28, 6) NOT NULL,
    [service_address_zip]       NVARCHAR (255)  NULL,
    [invoice_line_tax_group_id] INT             NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20160728-194612]
    ON [crimson].[InvoiceTaxLine]([invoice_tax_line_id] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160728-194631]
    ON [crimson].[InvoiceTaxLine]([last_mod_timestamp] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20161006-034914]
    ON [crimson].[InvoiceTaxLine]([invoice_line_id] ASC);

