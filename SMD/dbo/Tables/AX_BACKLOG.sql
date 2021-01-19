CREATE TABLE [dbo].[AX_BACKLOG] (
    [OrderDate]             DATETIME         NULL,
    [ShippingDateRequested] DATETIME         NOT NULL,
    [ShippingDateConfirmed] DATETIME         NOT NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [ShipTo]                NVARCHAR (40)    NOT NULL,
    [BillTo]                NVARCHAR (40)    NOT NULL,
    [BillToName]            NVARCHAR (100)   NULL,
    [PartnerType]           NVARCHAR (60)    NULL,
    [SoldTo]                NVARCHAR (40)    NOT NULL,
    [EndCustomer]           NVARCHAR (40)    NOT NULL,
    [EndCustomerName]       NVARCHAR (100)   NULL,
    [CustomerPurchaseOrder] NVARCHAR (50)    NOT NULL,
    [OrderType]             NVARCHAR (10)    NOT NULL,
    [Currency]              NVARCHAR (3)     NOT NULL,
    [Line]                  INT              NOT NULL,
    [StockCode]             NVARCHAR (40)    NOT NULL,
    [ItemGroupId]           NVARCHAR (30)    NULL,
    [ItemGroupName]         NVARCHAR (100)   NULL,
    [AxRevType]             INT              NULL,
    [SKU]                   NVARCHAR (20)    NULL,
    [LINENUM]               NUMERIC (28, 12) NOT NULL,
    [TotalLineQty]          NUMERIC (28, 12) NOT NULL,
    [NetAmount]             NUMERIC (28, 12) NOT NULL,
    [SALESSTATUS]           INT              NOT NULL,
    [LineStatus]            INT              NOT NULL,
    [SalesPoolId]           NVARCHAR (30)    NOT NULL,
    [IVARId]                NVARCHAR (40)    NOT NULL,
    [IVARName]              NVARCHAR (100)   NOT NULL,
    [EndCustArea]           NVARCHAR (30)    NULL,
    [ShipCity]              NVARCHAR (100)   NOT NULL,
    [ShipPostalCode]        NVARCHAR (10)    NOT NULL,
    [ShipState]             NVARCHAR (30)    NOT NULL,
    [ShipCountry]           NVARCHAR (30)    NOT NULL,
    [INVENTTRANSID]         NVARCHAR (20)    NOT NULL,
    [SEMSBEQTY]             NUMERIC (28, 12) NOT NULL,
    [SEMSBENETAMOUNT]       NUMERIC (28, 12) NOT NULL,
    [BookedUSD]             NUMERIC (38, 6)  NULL,
    [SupportListPrice]      NUMERIC (28, 12) NOT NULL,
    [RecId]                 VARCHAR (18)     NULL,
    [SemSbeParent]          NVARCHAR (20)    NOT NULL,
    [BacklogPlanRate]       NUMERIC (28, 12) NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_AX_BACKLOG-odate]
    ON [dbo].[AX_BACKLOG]([OrderDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AX_BACKLOG-rt]
    ON [dbo].[AX_BACKLOG]([AxRevType] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[AX_BACKLOG] TO [nkleinberg]
    AS [dbo];

