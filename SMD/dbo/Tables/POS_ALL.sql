CREATE TABLE [dbo].[POS_ALL] (
    [Invoice]         VARCHAR (100)    NULL,
    [VADId]           VARCHAR (15)     NOT NULL,
    [VADName]         NVARCHAR (100)   NULL,
    [InvoiceDate]     DATETIME         NULL,
    [SalesOrder]      VARCHAR (100)    NULL,
    [CustomerPO]      VARCHAR (100)    NULL,
    [ImpactNumber]    VARCHAR (50)     NULL,
    [PartnerName]     VARCHAR (100)    NULL,
    [CustomerId]      VARCHAR (50)     NULL,
    [CustomerName]    VARCHAR (100)    NULL,
    [Sku]             VARCHAR (50)     NULL,
    [Qty]             DECIMAL (18, 2)  NULL,
    [Billings]        DECIMAL (38, 6)  NULL,
    [ShipPostalCode]  VARCHAR (50)     NULL,
    [ShipCity]        VARCHAR (100)    NULL,
    [ShipState]       VARCHAR (100)    NULL,
    [ShipCountry]     VARCHAR (100)    NULL,
    [StockCode]       NVARCHAR (255)   NULL,
    [StockCodeDesc]   NVARCHAR (255)   NULL,
    [GMFamily]        VARCHAR (50)     NULL,
    [CUSTGROUP]       NVARCHAR (30)    NULL,
    [PartnerGId]      NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerG]        NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ItemGroupId]     NVARCHAR (30)    NULL,
    [ItemGroupName]   NVARCHAR (100)   NULL,
    [AxRevType]       INT              NULL,
    [ItemCostCurrent] NUMERIC (28, 12) NOT NULL,
    [CurrencyCode]    VARCHAR (3)      NOT NULL,
    [LocalBillings]   DECIMAL (18, 2)  NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[POS_ALL] TO [POS]
    AS [dbo];

