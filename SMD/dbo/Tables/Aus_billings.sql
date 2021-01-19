CREATE TABLE [dbo].[Aus_billings] (
    [AccountID]           NVARCHAR (255) NULL,
    [Account Name]        NVARCHAR (255) NULL,
    [InvoiceID]           FLOAT (53)     NULL,
    [DateGenerated]       DATETIME       NULL,
    [Category]            NVARCHAR (255) NULL,
    [Description]         NVARCHAR (255) NULL,
    [Quantity]            FLOAT (53)     NULL,
    [UnitPrice]           FLOAT (53)     NULL,
    [ServiceMonth]        DATETIME       NULL,
    [Charge]              FLOAT (53)     NULL,
    [ChargeType]          NVARCHAR (255) NULL,
    [ProdCategory]        NVARCHAR (255) NULL,
    [ProdSubCategory]     NVARCHAR (255) NULL,
    [ParentGroupID]       NVARCHAR (255) NULL,
    [ParentGroup]         NVARCHAR (255) NULL,
    [Service Period]      NVARCHAR (255) NULL,
    [Seat Classification] NVARCHAR (255) NULL
);

