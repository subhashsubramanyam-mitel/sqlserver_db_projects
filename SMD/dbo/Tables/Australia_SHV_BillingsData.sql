CREATE TABLE [dbo].[Australia_SHV_BillingsData] (
    [AccountID]           NVARCHAR (100) NULL,
    [Account Name]        NVARCHAR (255) NULL,
    [InvoiceID]           INT            NULL,
    [DateGenerated]       DATETIME       NULL,
    [Category]            NVARCHAR (100) NULL,
    [Description]         NVARCHAR (150) NULL,
    [Quantity]            INT            NULL,
    [UnitPrice]           MONEY          NULL,
    [ServiceMonth]        DATETIME       NULL,
    [Charge]              MONEY          NULL,
    [ChargeType]          NVARCHAR (100) NULL,
    [ProdCategory]        NVARCHAR (100) NULL,
    [ProdSubCategory]     NVARCHAR (100) NULL,
    [ParentGroupID]       NVARCHAR (100) NULL,
    [ParentGroup]         NVARCHAR (100) NULL,
    [Service Period]      NVARCHAR (100) NULL,
    [Seat Classification] NVARCHAR (255) NULL
);

