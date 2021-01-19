CREATE TABLE [dbo].[GS_PROF_REPORT] (
    [SalesOrder]  NVARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [InvoiceDate] DATETIME         NULL,
    [Invoice]     NVARCHAR (20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PO]          NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerId]   NVARCHAR (40)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerName] NVARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Customer]    NVARCHAR (40)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrderType]   NVARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SKU]         CHAR (20)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ITEMID]      CHAR (30)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ITEMDESC]    NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [QTY]         NUMERIC (38, 12) NULL,
    [NetSalesUSD] NUMERIC (38, 12) NULL,
    [GMFamily]    NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[GS_PROF_REPORT] TO [TacEngRole]
    AS [dbo];

