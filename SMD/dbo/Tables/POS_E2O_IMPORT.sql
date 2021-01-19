CREATE TABLE [dbo].[POS_E2O_IMPORT] (
    [TransactionId] NVARCHAR (20)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Created]       DATETIME        CONSTRAINT [DF_POS_E2O_IMPORT_Created] DEFAULT (getdate()) NULL,
    [CustomerId]    NVARCHAR (10)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CustomerName]  NVARCHAR (100)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SalesOrder]    NVARCHAR (20)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ShipDate]      DATE            NULL,
    [WarrantyStart] DATE            NULL,
    [WarrantyEnd]   DATE            NULL,
    [Sku]           NVARCHAR (30)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Description]   NVARCHAR (150)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SerialNumber]  NVARCHAR (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Qty]           NUMERIC (17, 3) NOT NULL,
    [ListPrice]     NUMERIC (17, 2) NOT NULL,
    [Currency]      NVARCHAR (5)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Status]        CHAR (1)        CONSTRAINT [DF_POS_E2O_IMPORT_Status] DEFAULT ('N') NULL,
    CONSTRAINT [PK_POS_E2O_IMPORT] PRIMARY KEY CLUSTERED ([TransactionId] ASC)
);

