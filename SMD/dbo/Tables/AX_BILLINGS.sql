CREATE TABLE [dbo].[AX_BILLINGS] (
    [OrderDate]             DATETIME         NULL,
    [RequestedShipDate]     DATETIME         NULL,
    [CustomerPo]            NVARCHAR (50)    NULL,
    [QmsQuoteNumber]        NVARCHAR (25)    NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [OrigSalesOrder]        NVARCHAR (20)    NOT NULL,
    [OrderType]             NVARCHAR (10)    NULL,
    [Invoice]               NVARCHAR (20)    NOT NULL,
    [InvoiceDate]           DATETIME         NOT NULL,
    [BillTo]                NVARCHAR (40)    NULL,
    [CUSTGROUP]             NVARCHAR (30)    NULL,
    [BillToName]            NVARCHAR (100)   NULL,
    [BillToPartnerType]     NVARCHAR (60)    NULL,
    [CustShipTo]            NVARCHAR (40)    NULL,
    [EndCust]               NVARCHAR (40)    NULL,
    [EndCustName]           NVARCHAR (100)   NULL,
    [CustSoldTo]            NVARCHAR (40)    NULL,
    [InvoiceLineNum]        NUMERIC (28, 12) NOT NULL,
    [SoLineNum]             INT              NOT NULL,
    [StockCode]             NVARCHAR (40)    NOT NULL,
    [ItemGroupId]           NVARCHAR (30)    NULL,
    [ItemGroupName]         NVARCHAR (100)   NULL,
    [AxRevType]             INT              NULL,
    [SKU]                   NVARCHAR (20)    NULL,
    [Rev]                   NVARCHAR (30)    NULL,
    [ItemDesc]              NVARCHAR (1000)  NOT NULL,
    [CURRENCYCODE]          NVARCHAR (3)     NOT NULL,
    [PRICEUNIT]             NUMERIC (28, 12) NOT NULL,
    [QTY]                   NUMERIC (28, 12) NOT NULL,
    [PromoPrice]            NUMERIC (28, 12) NOT NULL,
    [DMMREFPRICE]           NUMERIC (28, 12) NOT NULL,
    [NetSalesUSD]           NUMERIC (28, 12) NOT NULL,
    [NetSalesLocalCurrency] NUMERIC (28, 12) NOT NULL,
    [ProfitCenter]          NVARCHAR (30)    NOT NULL,
    [Country]               NVARCHAR (30)    NOT NULL,
    [SalesArea]             NVARCHAR (30)    NULL,
    [LEDGERACCOUNT]         NVARCHAR (40)    NOT NULL,
    [Dept]                  NVARCHAR (30)    NOT NULL,
    [Purpose]               NVARCHAR (30)    NOT NULL,
    [ShipCity]              NVARCHAR (100)   NULL,
    [ShipPostalCode]        NVARCHAR (10)    NULL,
    [ShipState]             NVARCHAR (30)    NULL,
    [ShipCounty]            NVARCHAR (30)    NULL,
    [ShipCountry]           NVARCHAR (30)    NULL,
    [DiscountBase]          NUMERIC (28, 12) NULL,
    [DiscountVolume]        NUMERIC (28, 12) NULL,
    [DiscountCsat]          NUMERIC (28, 12) NULL,
    [DiscountVpa]           NUMERIC (28, 12) NULL,
    [DiscountType]          NVARCHAR (10)    NULL,
    [DiscountConcession]    NUMERIC (28, 12) NULL,
    [DiscountDemo]          NUMERIC (28, 12) NULL,
    [DiscountNewPartner]    NUMERIC (28, 12) NULL,
    [DiscountDollar]        INT              NULL,
    [SEMLINENUM]            INT              NOT NULL,
    [INVENTDIMID]           NVARCHAR (20)    NULL,
    [Serial]                NVARCHAR (20)    NULL,
    [SalesPoolId]           NVARCHAR (30)    NULL,
    [IVARName]              NVARCHAR (100)   NULL,
    [IVARId]                NVARCHAR (40)    NULL,
    [EndCustArea]           NVARCHAR (30)    NULL,
    [SemSbeParent]          NVARCHAR (20)    NULL,
    [SemSbeComp]            INT              NULL,
    [INVENTTRANSID]         NVARCHAR (20)    NULL,
    [ShippingDateRequested] DATETIME         NULL,
    [ShippingDateConfirmed] DATETIME         NULL,
    [InvoiceDateUTC]        DATETIME         NOT NULL,
    [EndCustCreateDate]     DATETIME         NULL,
    [RecId]                 BIGINT           NOT NULL,
    [BossInvoiceGroupId]    NVARCHAR (30)    NULL,
    [SemQmsList]            NUMERIC (28, 12) NULL,
    [ReturnReasonCodeId]    NVARCHAR (10)    NULL,
    [ReturnQty]             NUMERIC (28, 12) NULL,
    [NetSalesPlanRate]      NUMERIC (28, 12) NULL,
    [Connect]               VARCHAR (50)     NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_AX_BILLINGS-Idate]
    ON [dbo].[AX_BILLINGS]([InvoiceDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AX_BILLINGS-rt]
    ON [dbo].[AX_BILLINGS]([AxRevType] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[AX_BILLINGS] TO [CANDY\BPaddock]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[AX_BILLINGS] TO [nkleinberg]
    AS [dbo];

