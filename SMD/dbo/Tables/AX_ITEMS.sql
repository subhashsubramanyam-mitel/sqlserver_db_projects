CREATE TABLE [dbo].[AX_ITEMS] (
    [StockCode]       NVARCHAR (40)    NOT NULL,
    [SKU]             NVARCHAR (20)    NOT NULL,
    [ItemGroupId]     NVARCHAR (30)    NOT NULL,
    [ItemGroupName]   NVARCHAR (100)   NULL,
    [AxRevType]       INT              NULL,
    [ItemCostCurrent] NUMERIC (28, 12) NOT NULL,
    [itemname]        NVARCHAR (100)   NOT NULL,
    [rn]              BIGINT           NULL
);

