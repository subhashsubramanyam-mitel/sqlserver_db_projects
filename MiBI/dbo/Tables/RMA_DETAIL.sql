CREATE TABLE [dbo].[RMA_DETAIL] (
    [Id]        INT          NOT NULL,
    [Created]   DATETIME     NOT NULL,
    [TxnId]     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [AssetId]   VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sku]       VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [StockCode] VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Qty]       FLOAT (53)   NULL,
    [Serial]    VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DateCode]  VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [MacId]     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RMA_DETAIL] TO [TacEngRole]
    AS [dbo];

