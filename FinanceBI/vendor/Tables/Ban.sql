CREATE TABLE [vendor].[Ban] (
    [id]                  INT           NOT NULL,
    [vendor_id]           INT           NULL,
    [name]                VARCHAR (255) NULL,
    [profile]             VARCHAR (255) NULL,
    [qa]                  VARCHAR (255) NULL,
    [qa_normalized]       VARCHAR (255) NULL,
    [reviewed_bill_at]    VARCHAR (255) NULL,
    [run_claims]          VARCHAR (255) NULL,
    [zone]                VARCHAR (255) NULL,
    [report]              VARCHAR (255) NULL,
    [usage_cost_discount] VARCHAR (255) NULL,
    [product_by_row]      VARCHAR (255) NULL,
    [active]              VARCHAR (255) NULL,
    [mrc_cost_discount]   VARCHAR (255) NULL,
    [ban_alias]           VARCHAR (255) NULL,
    [corporate]           VARCHAR (255) NULL,
    [classification]      VARCHAR (255) NULL
);

