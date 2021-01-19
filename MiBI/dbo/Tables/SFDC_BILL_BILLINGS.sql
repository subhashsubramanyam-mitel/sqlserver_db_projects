﻿CREATE TABLE [dbo].[SFDC_BILL_BILLINGS] (
    [Invoice]                 NVARCHAR (20)  NULL,
    [InvoiceDate]             DATETIME       NULL,
    [SalesOrder]              NVARCHAR (20)  NULL,
    [OrderDate]               DATETIME       NULL,
    [ImpactNumber]            NVARCHAR (40)  NULL,
    [BillingsComp]            FLOAT (53)     NULL,
    [MgnCompUplifted]         FLOAT (53)     NULL,
    [PartnerSfdcId]           NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]                CHAR (255)     NULL,
    [OrigSalesArea]           CHAR (30)      NULL,
    [FiscalQuarterCommission] CHAR (7)       NULL,
    [CalendarMonthCommission] CHAR (8)       NULL,
    [GOV]                     INT            NOT NULL,
    [MAP]                     INT            NOT NULL,
    [CustSE_ID]               VARCHAR (50)   NULL,
    [AXTerritoryCode]         NVARCHAR (255) NULL,
    [EndCustBuild]            CHAR (10)      NULL,
    [QmsOrderNumber]          NVARCHAR (25)  NULL,
    [CustomerPo]              NVARCHAR (50)  NULL,
    [REVtype]                 NVARCHAR (255) NULL,
    [GOVclass]                CHAR (10)      NULL,
    [OrderType]               NVARCHAR (10)  NULL,
    [EndCustName]             CHAR (255)     NULL,
    [EndCust]                 VARCHAR (50)   NULL
);

