CREATE TABLE [dbo].[SFDC_DNS_BILLING_TRK_bk] (
    [Created]      DATETIME       NULL,
    [RecId]        VARCHAR (30)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SalesOrder]   VARCHAR (15)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SKU]          VARCHAR (100)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [QTY]          INT            NULL,
    [LineAmount]   VARCHAR (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CurrencyCode] NVARCHAR (3)   NOT NULL,
    [InvoiceDate]  DATETIME       NULL,
    [Margin]       INT            NULL,
    [Status]       VARCHAR (5)    NULL,
    [Error]        TEXT           NULL
);

