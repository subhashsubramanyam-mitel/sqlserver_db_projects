CREATE TABLE [AUinvoice].[FebBillWMapping] (
    [ AccountID]          INT            NULL,
    [Account Name]        NVARCHAR (255) NULL,
    [InvoiceID]           INT            NULL,
    [DateGenerated]       DATETIME       NULL,
    [Category]            NVARCHAR (255) NULL,
    [Description]         NVARCHAR (255) NULL,
    [Quantity]            INT            NULL,
    [UnitPrice]           FLOAT (53)     NULL,
    [ServiceMonth]        DATETIME       NULL,
    [ChargeType]          NVARCHAR (255) NULL,
    [Charge]              FLOAT (53)     NULL,
    [ProdCategory]        NVARCHAR (255) NULL,
    [ProdSubCategory]     NVARCHAR (255) NULL,
    [Seat Classification] NVARCHAR (255) NULL
);

