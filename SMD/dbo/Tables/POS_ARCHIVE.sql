﻿CREATE TABLE [dbo].[POS_ARCHIVE] (
    [Invoice]        NVARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [VADId]          INT              NULL,
    [VADName]        VARCHAR (100)    NULL,
    [InvoiceDate]    DATETIME         NULL,
    [SalesOrder]     NVARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CustomerPo]     NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ImpactNumber]   NVARCHAR (40)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Partner]        NVARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCust]        NVARCHAR (40)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EndCustName]    CHAR (255)       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sku]            CHAR (20)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Qty]            NUMERIC (38, 12) NULL,
    [NetSalesUSD]    NUMERIC (38, 12) NULL,
    [ShipPostalCode] NVARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipCity]       NVARCHAR (60)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipState]      NVARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipCountry]    NVARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [StockCode]      CHAR (30)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [StockCodeDesc]  NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [GMFamily]       NVARCHAR (50)    NULL,
    [custgroup]      INT              NULL,
    [PartnerGId]     NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]       NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ItemGroupId]    NVARCHAR (30)    NOT NULL,
    [ItemGroupName]  NVARCHAR (100)   NULL,
    [AxRevType]      INT              NULL
);

