CREATE TABLE [dbo].[RMA_HEADER] (
    [Id]          INT           NOT NULL,
    [TxnId]       VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Created]     DATETIME      NOT NULL,
    [CustomerId]  VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerId]   VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipStreet]  VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipZip]     VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ShipCountry] VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Reason]      VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SalesOrder]  VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [RmaNumber]   VARCHAR (15)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SrNumber]    VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IntStatus]   CHAR (1)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [RmaStatus]   CHAR (1)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [TrkNumber]   VARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Description] VARCHAR (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RMA_HEADER] TO [TacEngRole]
    AS [dbo];

