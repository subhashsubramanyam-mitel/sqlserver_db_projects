﻿CREATE TABLE [dbo].[CI_POS_BILLINGS_test] (
    [Source]                        VARCHAR (3)      NOT NULL,
    [OrderDate]                     DATETIME         NULL,
    [Invoice]                       NVARCHAR (100)   NULL,
    [VADId]                         VARCHAR (15)     NULL,
    [VADName]                       NVARCHAR (100)   NULL,
    [InvoiceDate]                   DATETIME         NULL,
    [SalesOrder]                    NVARCHAR (100)   NULL,
    [CustomerPo]                    NVARCHAR (100)   NULL,
    [ImpactNumber]                  NVARCHAR (50)    NULL,
    [BillToName]                    NVARCHAR (100)   NULL,
    [EndCust]                       NVARCHAR (50)    NULL,
    [EndCustName]                   NVARCHAR (100)   NULL,
    [SKU]                           NVARCHAR (50)    NULL,
    [QTY]                           NUMERIC (28, 12) NULL,
    [NetSalesUSD]                   NUMERIC (29, 12) NULL,
    [ShipPostalCode]                NVARCHAR (50)    NULL,
    [ShipCity]                      NVARCHAR (100)   NULL,
    [ShipState]                     NVARCHAR (100)   NULL,
    [ShipCountry]                   NVARCHAR (100)   NULL,
    [StockCode]                     NVARCHAR (255)   NULL,
    [ItemDesc]                      NVARCHAR (1000)  NULL,
    [CUSTGROUP]                     NVARCHAR (30)    NULL,
    [OrigSalesOrder]                NVARCHAR (100)   NULL,
    [OrderType]                     NVARCHAR (10)    NULL,
    [GMFamily]                      VARCHAR (50)     NULL,
    [PartnerGId]                    NVARCHAR (255)   NULL,
    [PartnerG]                      NVARCHAR (255)   NULL,
    [RevType]                       VARCHAR (10)     NULL,
    [PartnerId]                     NVARCHAR (50)    NULL,
    [Partner]                       NVARCHAR (100)   NULL,
    [AX_InvoiceDateUTC]             DATETIME         NULL,
    [ItemGroupName]                 NVARCHAR (100)   NULL,
    [SC_Billings]                   NUMERIC (31, 12) NULL,
    [ItemCost]                      NUMERIC (28, 12) NOT NULL,
    [RequestedShipDate]             DATETIME         NULL,
    [SalesPoolId]                   NVARCHAR (30)    NULL,
    [EndCustCreateDate]             DATETIME         NULL,
    [CurrencyCode]                  NVARCHAR (3)     NULL,
    [NetSalesLocalCurrency]         NUMERIC (28, 12) NULL,
    [InvoiceDate_DateFormat]        DATE             NULL,
    [FYQuarter]                     VARCHAR (10)     NULL,
    [GOVAccount]                    VARCHAR (50)     NULL,
    [GOVClass]                      VARCHAR (50)     NULL,
    [NetSalesPlanRate]              NUMERIC (28, 12) NULL,
    [DiscountID_1]                  VARCHAR (255)    NULL,
    [DiscountAmount_1]              FLOAT (53)       NULL,
    [DiscountID_2]                  NVARCHAR (255)   NULL,
    [DiscountAmount_2]              FLOAT (53)       NULL,
    [DiscountID_3]                  VARCHAR (255)    NULL,
    [DiscountAmount_3]              FLOAT (53)       NULL,
    [VAD_PurchasePrice_Reported]    FLOAT (53)       NULL,
    [VAD_ExtPurchasePrice_Reported] FLOAT (53)       NULL,
    [VAD_Net_Price]                 FLOAT (53)       NULL,
    [List_Price_Reported]           FLOAT (53)       NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CI_POS_BILLINGS_test] TO [CANDY\wnolan]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CI_POS_BILLINGS_test] TO [CANDY\JHadden]
    AS [dbo];

