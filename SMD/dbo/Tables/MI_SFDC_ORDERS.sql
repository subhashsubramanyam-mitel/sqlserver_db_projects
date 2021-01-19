CREATE TABLE [dbo].[MI_SFDC_ORDERS] (
    [Created]               DATETIME         CONSTRAINT [DF_MI_SFDC_ORDERS_Created] DEFAULT (getdate()) NULL,
    [SalesOrder]            NVARCHAR (20)    NOT NULL,
    [OrderDate]             DATETIME         NULL,
    [OrderType]             NVARCHAR (10)    NOT NULL,
    [SoldTo]                NVARCHAR (40)    NOT NULL,
    [SoldToName]            NVARCHAR (100)   NOT NULL,
    [CustomerPurchaseOrder] NVARCHAR (50)    NOT NULL,
    [Currency]              NVARCHAR (3)     NOT NULL,
    [ShippingDateRequested] DATETIME         NULL,
    [ModifiedDateTime]      DATETIME         NOT NULL,
    [SAPId]                 VARCHAR (50)     NULL,
    [SupportStart]          DATETIME         NULL,
    [SupportEnd]            DATETIME         NULL,
    [OrderTotal]            NUMERIC (28, 12) NULL,
    [Status]                VARCHAR (1)      CONSTRAINT [DF_MI_SFDC_ORDERS_Status] DEFAULT ('N') NOT NULL,
    [Error]                 TEXT             NULL,
    CONSTRAINT [PK_MI_SFDC_ORDERS] PRIMARY KEY CLUSTERED ([SalesOrder] ASC)
);

