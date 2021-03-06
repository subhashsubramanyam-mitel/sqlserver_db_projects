﻿CREATE TABLE [ax].[MatVwInvoiceLine_Past] (
    [AxId]              BIGINT           NULL,
    [LineItemId]        INT              NULL,
    [ProductId]         INT              NULL,
    [KitChecksumValue]  INT              NOT NULL,
    [AxItemid]          NVARCHAR (40)    NOT NULL,
    [SalesPrice]        NUMERIC (28, 12) NULL,
    [SalesQty]          NUMERIC (28, 12) NOT NULL,
    [InvoiceMonth]      DATE             NULL,
    [DatePeriodStart]   DATETIME         NULL,
    [DatePeriodEnd]     DATETIME         NULL,
    [Name]              NVARCHAR (1024)  NULL,
    [LocationId]        INT              NULL,
    [Addressid]         INT              NULL,
    [City]              NVARCHAR (100)   NULL,
    [State]             NVARCHAR (30)    NULL,
    [ZipCode]           NVARCHAR (10)    NULL,
    [Country]           NVARCHAR (30)    NULL,
    [Jurisdiction]      NVARCHAR (16)    NULL,
    [InvoiceId]         INT              NULL,
    [InvoiceGroupId]    INT              NOT NULL,
    [ServiceGroupName]  INT              NULL,
    [BillingContact]    NVARCHAR (201)   NULL,
    [BillingCategoryId] INT              NULL,
    [ChargeCategory]    NVARCHAR (64)    NULL,
    [ServiceMonth]      DATETIME2 (7)    NULL,
    [Amount]            NUMERIC (28, 12) NULL,
    [CurrencyCode]      NVARCHAR (3)     NOT NULL,
    [ProfitCenter]      NVARCHAR (30)    NOT NULL,
    [AxSalesId]         NVARCHAR (20)    NOT NULL,
    [AxLineNum]         NUMERIC (28, 12) NOT NULL,
    [RECVERSION]        INT              NOT NULL,
    [RECID]             BIGINT           NOT NULL
);

