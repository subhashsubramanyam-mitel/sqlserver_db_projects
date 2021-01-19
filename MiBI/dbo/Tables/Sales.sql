CREATE TABLE [dbo].[Sales] (
    [Region]        VARCHAR (50) NULL,
    [Country]       VARCHAR (50) NULL,
    [ItemType]      VARCHAR (50) NULL,
    [SalesChannel]  VARCHAR (50) NULL,
    [OrderPriority] VARCHAR (50) NULL,
    [OrderDate]     DATETIME     NULL,
    [OrderID]       BIGINT       NULL,
    [ShipDate]      DATETIME     NULL,
    [UnitsSold]     FLOAT (53)   NULL,
    [UnitPrice]     FLOAT (53)   NULL,
    [UnitCost]      FLOAT (53)   NULL,
    [TotalRevenue]  FLOAT (53)   NULL,
    [TotalCost]     FLOAT (53)   NULL,
    [TotalProfit]   FLOAT (53)   NULL
);

