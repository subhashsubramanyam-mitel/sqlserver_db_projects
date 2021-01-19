CREATE TABLE [shv].[CustomerServices] (
    [AccountID]           NVARCHAR (255) NULL,
    [AccountName]         NVARCHAR (255) NULL,
    [InvoiceID]           FLOAT (53)     NULL,
    [DateGenerated]       FLOAT (53)     NULL,
    [Category]            NVARCHAR (255) NULL,
    [ProductId]           NVARCHAR (255) NULL,
    [Quantity]            FLOAT (53)     NULL,
    [UnitPrice]           FLOAT (53)     NULL,
    [ServiceMonth]        FLOAT (53)     NULL,
    [Charge]              FLOAT (53)     NULL,
    [ChargeType]          NVARCHAR (255) NULL,
    [ProdCategory]        NVARCHAR (255) NULL,
    [ProdSubCategory]     NVARCHAR (255) NULL,
    [ParentGroupID]       NVARCHAR (255) NULL,
    [ParentGroup]         NVARCHAR (255) NULL,
    [Service Period]      NVARCHAR (255) NULL,
    [Seat Classification] NVARCHAR (255) NULL,
    [Profit Center]       NVARCHAR (255) NULL,
    [GL Account]          NVARCHAR (255) NULL
);

