CREATE TABLE [dbo].[RMA] (
    [Id]                   INT           NOT NULL,
    [TxnId]                VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Created]              DATETIME      NOT NULL,
    [CustomerId]           VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerId]            VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AccountName]          VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ContactName]          VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CustomerEmail]        VARCHAR (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipCity]             VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipState]            VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipEmail]            VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipPhone]            VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipContact]          VARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipStreet]           VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipZip]              VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipCountry]          VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Reason]               VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SalesOrder]           VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [RmaNumber]            VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SrNumber]             VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IntStatus]            CHAR (1)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [RmaStatus]            CHAR (1)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [TrkNumber]            VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Description]          VARCHAR (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AssetId]              VARCHAR (18)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sku]                  VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [StockCode]            VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Qty]                  FLOAT (53)    NULL,
    [Serial]               VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DateCode]             VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [MacId]                VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ActiveServiceProduct] VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RMA] TO [TacEngRole]
    AS [dbo];

