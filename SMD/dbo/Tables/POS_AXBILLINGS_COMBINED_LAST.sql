﻿CREATE TABLE [dbo].[POS_AXBILLINGS_COMBINED_LAST] (
    [Source]                 VARCHAR (3)      NOT NULL,
    [OrderDate]              INT              NULL,
    [Invoice]                VARCHAR (100)    NULL,
    [VADId]                  VARCHAR (15)     NOT NULL,
    [VADName]                NVARCHAR (100)   NULL,
    [InvoiceDate]            DATETIME         NULL,
    [SalesOrder]             VARCHAR (100)    NULL,
    [CustomerPO]             VARCHAR (100)    NULL,
    [ImpactNumber]           VARCHAR (50)     NULL,
    [PartnerName]            VARCHAR (100)    NULL,
    [CustomerId]             VARCHAR (50)     NULL,
    [CustomerName]           VARCHAR (100)    NULL,
    [Sku]                    VARCHAR (50)     NULL,
    [Qty]                    DECIMAL (18, 2)  NULL,
    [Billings]               DECIMAL (38, 6)  NULL,
    [ShipPostalCode]         VARCHAR (50)     NULL,
    [ShipCity]               VARCHAR (100)    NULL,
    [ShipState]              VARCHAR (100)    NULL,
    [ShipCountry]            VARCHAR (100)    NULL,
    [StockCode]              NVARCHAR (255)   NULL,
    [StockCodeDesc]          NVARCHAR (255)   NULL,
    [CUSTGROUP]              NVARCHAR (30)    NULL,
    [OrigSalesOrder]         VARCHAR (100)    NULL,
    [OrderType]              VARCHAR (3)      NOT NULL,
    [GMFamily]               VARCHAR (50)     NULL,
    [PartnerGId]             NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]               NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [RevType]                VARCHAR (10)     NOT NULL,
    [PartnerId]              VARCHAR (50)     NULL,
    [Partner]                VARCHAR (100)    NULL,
    [AX_InvoiceDateUTC]      DATETIME         NULL,
    [ItemGroupName]          NVARCHAR (100)   NULL,
    [SC_Billings]            NUMERIC (38, 6)  NULL,
    [ItemCost]               NUMERIC (28, 12) NOT NULL,
    [RequestedShipDate]      DATETIME         NULL,
    [SalesPoolId]            INT              NULL,
    [EndCustCreateDate]      INT              NULL,
    [CurrencyCode]           VARCHAR (3)      NOT NULL,
    [NetSalesLocalCurrency]  DECIMAL (18, 2)  NULL,
    [SC_VARId]               VARCHAR (50)     NULL,
    [ItemSubType]            VARCHAR (100)    COLLATE Latin1_General_BIN NULL,
    [InvoiceDate_DateFormat] DATE             NULL,
    [FYQuarter]              VARCHAR (7)      NULL,
    [NetSalesPlanRate]       DECIMAL (38, 6)  NULL
);
