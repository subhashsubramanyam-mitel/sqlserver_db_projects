CREATE TABLE [AUbilling].[InvoiceItem] (
    [AU AccountID]    NVARCHAR (255) NULL,
    [Account Name]    NVARCHAR (255) NULL,
    [InvoiceID]       FLOAT (53)     NULL,
    [DateGenerated]   DATE           NULL,
    [Category]        NVARCHAR (255) NULL,
    [Description]     NVARCHAR (255) NULL,
    [Quantity]        FLOAT (53)     NULL,
    [UnitPrice]       FLOAT (53)     NULL,
    [ServiceMonth]    DATE           NULL,
    [Charge]          FLOAT (53)     NULL,
    [ProdCategory]    VARCHAR (50)   NULL,
    [ProdSubCategory] VARCHAR (50)   NULL,
    [ChargeType]      VARCHAR (50)   NULL
);

