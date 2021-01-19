CREATE TABLE [crimson].[PriceSheetProduct] (
    [price_sheet_product_id]   INT              NOT NULL,
    [product_id]               INT              NOT NULL,
    [pricing_structure_value]  NVARCHAR (255)   NULL,
    [base_fee_amount]          NUMERIC (28, 6)  NOT NULL,
    [price_sheet_version_id]   INT              NOT NULL,
    [pricing_horizon_value]    NVARCHAR (255)   NULL,
    [create_user_id]           INT              NOT NULL,
    [create_timestamp]         DATETIME2 (7)    NOT NULL,
    [last_mod_user_id]         INT              NOT NULL,
    [last_mod_timestamp]       DATETIME2 (7)    NOT NULL,
    [delete_user_id]           INT              NULL,
    [delete_timestamp]         DATETIME2 (7)    NULL,
    [product_rate_deck_id]     INT              NULL,
    [price_sheet_product_uuid] UNIQUEIDENTIFIER NOT NULL,
    [sf_record_id]             NVARCHAR (255)   NULL,
    [sf_last_sync_timestamp]   DATETIME2 (7)    NULL,
    [product_currency_rate_id] INT              NOT NULL
);

