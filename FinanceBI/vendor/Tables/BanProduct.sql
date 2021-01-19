CREATE TABLE [vendor].[BanProduct] (
    [id]         INT           NOT NULL,
    [ban_id]     INT           NULL,
    [product_id] INT           NULL,
    [keywords]   VARCHAR (255) NULL,
    [is_default] INT           NULL,
    [priority]   INT           NULL,
    [is_charge]  INT           NULL,
    [is_usage]   INT           NULL,
    [period]     VARCHAR (255) NULL
);

