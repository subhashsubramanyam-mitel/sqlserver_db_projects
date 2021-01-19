CREATE TABLE [dbo].[AX_Table_StdCost] (
    [SKU]        NVARCHAR (20)    NOT NULL,
    [RevType]    NVARCHAR (100)   NULL,
    [ItemGroup]  NVARCHAR (100)   NULL,
    [StockCode]  NVARCHAR (40)    NULL,
    [Part]       NVARCHAR (150)   NULL,
    [ListPrice]  NUMERIC (28, 12) NULL,
    [StdCostRD]  NUMERIC (28, 12) NULL,
    [CreateDate] DATE             NULL
);

