CREATE TABLE [dbo].[AX_BILLINGS_WITHBUNDLES] (
    [SalesOrder]    NVARCHAR (20)    NOT NULL,
    [OrderDate]     DATETIME         NULL,
    [InvoiceDate]   DATETIME         NOT NULL,
    [BillTo]        NVARCHAR (40)    NULL,
    [BillToName]    NVARCHAR (100)   NULL,
    [IVARId]        NVARCHAR (40)    NULL,
    [IVARName]      NVARCHAR (100)   NULL,
    [EndCust]       NVARCHAR (40)    NULL,
    [EndCustName]   NVARCHAR (100)   NULL,
    [CustomerPo]    NVARCHAR (50)    NULL,
    [SoLineNum]     INT              NOT NULL,
    [SKU]           NVARCHAR (20)    NULL,
    [StockCode]     NVARCHAR (40)    NOT NULL,
    [ItemGroupId]   NVARCHAR (30)    NULL,
    [ItemGroupName] NVARCHAR (100)   NULL,
    [AxRevType]     INT              NULL,
    [QTY]           NUMERIC (28, 12) NOT NULL,
    [NetSalesUSD]   NUMERIC (28, 12) NOT NULL,
    [RecId]         VARCHAR (18)     NULL,
    [InventTransId] NVARCHAR (20)    NULL,
    [SemQmsList]    NUMERIC (28, 12) NULL,
    [Currency]      NVARCHAR (3)     NOT NULL,
    [SemSbeParent]  NVARCHAR (20)    NULL,
    [SemSbeQty]     NUMERIC (28, 12) NOT NULL,
    [OrderType]     NVARCHAR (10)    NULL,
    [InventDimId]   NVARCHAR (20)    NULL,
    [StockCodeDesc] VARCHAR (500)    COLLATE Latin1_General_BIN NULL,
    [BusinessLine]  VARCHAR (100)    COLLATE Latin1_General_BIN NULL,
    [MarketFamily]  VARCHAR (100)    COLLATE Latin1_General_BIN NULL,
    [SupportItem]   VARCHAR (15)     COLLATE Latin1_General_BIN NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[AX_BILLINGS_WITHBUNDLES] TO [CANDY\BPaddock]
    AS [dbo];

