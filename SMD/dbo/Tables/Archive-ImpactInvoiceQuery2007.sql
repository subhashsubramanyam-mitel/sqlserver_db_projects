CREATE TABLE [dbo].[Archive-ImpactInvoiceQuery2007] (
    [Name]             CHAR (30)       NULL,
    [Description]      CHAR (30)       NULL,
    [Invoice]          CHAR (6)        NOT NULL,
    [QtyInvoiced]      DECIMAL (10, 3) NULL,
    [SalesOrder]       CHAR (6)        NULL,
    [CustomerPoNumber] CHAR (30)       NULL,
    [NetSalesValue]    DECIMAL (14, 2) NULL,
    [DiscValue]        DECIMAL (14, 2) NULL,
    [InvoiceDate]      DATETIME        NULL,
    [Customer]         CHAR (7)        NOT NULL,
    [UserField1]       CHAR (10)       NULL
);

