CREATE TABLE [crimson].[ProductShoretelCategory] (
    [product_shoretel_category_id] INT            NOT NULL,
    [product_id]                   INT            NULL,
    [ax_account]                   INT            NULL,
    [ax_account_description]       NVARCHAR (255) NULL,
    [ax_profit_center]             INT            NULL,
    [ax_profit_center_description] NVARCHAR (255) NULL,
    [charge_category]              NVARCHAR (255) NULL
);

