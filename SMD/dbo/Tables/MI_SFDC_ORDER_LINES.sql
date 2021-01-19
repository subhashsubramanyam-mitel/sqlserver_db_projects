CREATE TABLE [dbo].[MI_SFDC_ORDER_LINES] (
    [Created]               DATETIME         CONSTRAINT [DF_MI_SFDC_ORDER_LINES_Created] DEFAULT (getdate()) NOT NULL,
    [RecId]                 VARCHAR (18)     NOT NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [ShipTo]                NVARCHAR (40)    NOT NULL,
    [Line]                  INT              NOT NULL,
    [TotalLineQty]          NUMERIC (28, 12) NOT NULL,
    [NetAmount]             NUMERIC (28, 12) NOT NULL,
    [SKU]                   NVARCHAR (20)    NULL,
    [ProductName]           VARCHAR (500)    COLLATE Latin1_General_BIN NULL,
    [LineStatus]            INT              NOT NULL,
    [ShippingDateRequested] DATETIME         NOT NULL,
    [isRecurring]           INT              NOT NULL,
    [InventTransId]         NVARCHAR (20)    NOT NULL,
    [SupportStart]          DATETIME         NULL,
    [SupportEnd]            DATETIME         NULL,
    [Status]                VARCHAR (1)      CONSTRAINT [DF_MI_SFDC_ORDER_LINES_Status] DEFAULT ('N') NOT NULL,
    [Error]                 TEXT             NULL,
    CONSTRAINT [PK_MI_SFDC_ORDER_LINES] PRIMARY KEY CLUSTERED ([RecId] ASC)
);

