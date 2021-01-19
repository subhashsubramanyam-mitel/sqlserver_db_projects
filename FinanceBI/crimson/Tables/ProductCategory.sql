CREATE TABLE [crimson].[ProductCategory] (
    [product_category_id] INT           NOT NULL,
    [description]         NVARCHAR (40) NOT NULL,
    [business_entity_id]  INT           NOT NULL,
    [create_user_id]      INT           NOT NULL,
    [create_timestamp]    DATETIME2 (7) NOT NULL,
    [last_mod_user_id]    INT           NOT NULL,
    [last_mod_timestamp]  DATETIME2 (7) NOT NULL,
    [uses_components]     VARCHAR (5)   NOT NULL
);

