CREATE TABLE [vendor].[VPaymentNAdjustment] (
    [id]                 INT           NOT NULL,
    [ban]                VARCHAR (255) NULL,
    [bill_date]          VARCHAR (255) NULL,
    [charge_type]        VARCHAR (255) NULL,
    [amount]             VARCHAR (255) NULL,
    [description]        VARCHAR (255) NULL,
    [transaction_date]   VARCHAR (255) NULL,
    [reference]          VARCHAR (255) NULL,
    [sub_charge_type]    VARCHAR (255) NULL,
    [incoming_file_name] VARCHAR (255) NULL,
    [profile]            VARCHAR (255) NULL,
    [generated_at]       VARCHAR (255) NULL,
    [period]             VARCHAR (255) NULL
);

