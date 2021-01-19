CREATE TABLE [dbo].[RMA_AX_INVENT] (
    [ReturnStatusHeader] VARCHAR (50)    NULL,
    [ReturnStatusLine]   VARCHAR (50)    NULL,
    [RMANumber]          VARCHAR (50)    NULL,
    [SalesOrder]         VARCHAR (50)    NULL,
    [ReturnType]         VARCHAR (100)   NULL,
    [OrderType]          VARCHAR (100)   NULL,
    [ItemNumber]         VARCHAR (100)   NULL,
    [ItemGroup]          VARCHAR (100)   NULL,
    [Revision]           VARCHAR (100)   NULL,
    [PartDescription]    VARCHAR (200)   NULL,
    [Customer]           VARCHAR (50)    NULL,
    [CustomerName]       VARCHAR (200)   NULL,
    [QuantityOrdered]    VARCHAR (50)    NULL,
    [QuantityShipped]    VARCHAR (50)    NULL,
    [StandardCost]       DECIMAL (18, 2) NULL,
    [ExtStandardCost]    DECIMAL (18, 2) NULL,
    [ShipDate]           DATETIME        NULL,
    [ExpectedReturnDate] DATETIME        NULL,
    [ArrivalDate]        DATETIME        NULL,
    [Description]        TEXT            NULL,
    [SalesTerritory]     VARCHAR (100)   NULL,
    [Warehouse]          VARCHAR (100)   NULL,
    [ReasonCode]         VARCHAR (100)   NULL,
    [Description2]       TEXT            NULL,
    [InvoiceAccount]     VARCHAR (100)   NULL,
    [InvoiceAccountName] VARCHAR (200)   NULL
);


GO
GRANT ALTER
    ON OBJECT::[dbo].[RMA_AX_INVENT] TO [CANDY\JOh]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[RMA_AX_INVENT] TO [CANDY\JOh]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[RMA_AX_INVENT] TO [CANDY\JOh]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RMA_AX_INVENT] TO [CANDY\JOh]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[RMA_AX_INVENT] TO [CANDY\JOh]
    AS [dbo];

