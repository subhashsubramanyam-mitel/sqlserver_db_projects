CREATE TABLE [dbo].[MI_SFDC_INVOICE_LINES] (
    [Created]               DATETIME         CONSTRAINT [DF_MI_SFDC_INVOICE_LINES_Created] DEFAULT (getdate()) NOT NULL,
    [RecId]                 BIGINT           NOT NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [InvoiceDate]           DATETIME         NOT NULL,
    [InvoiceLineNum]        NUMERIC (28, 12) NOT NULL,
    [NetSalesUSD]           NUMERIC (28, 12) NOT NULL,
    [NetSalesLocalCurrency] NUMERIC (28, 12) NULL,
    [AxRevType]             INT              NULL,
    [InventTransId]         NVARCHAR (20)    NULL,
    [ProductName]           VARCHAR (500)    COLLATE Latin1_General_BIN NULL,
    [isReturn]              INT              NULL,
    [Status]                VARCHAR (1)      CONSTRAINT [DF_MI_SFDC_INVOICE_LINES_Status] DEFAULT ('N') NOT NULL,
    [Error]                 TEXT             NULL,
    CONSTRAINT [PK_MI_SFDC_INVOICE_LINES] PRIMARY KEY CLUSTERED ([RecId] ASC)
);

