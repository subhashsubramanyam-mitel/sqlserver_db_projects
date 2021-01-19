CREATE TABLE [dbo].[SFDC_OPTY_TRK_bkup_Ingram] (
    [Created]           DATETIME         NULL,
    [Source]            VARCHAR (15)     NOT NULL,
    [QNumber]           VARCHAR (50)     NULL,
    [OrderDate]         DATETIME         NOT NULL,
    [ReqShipDate]       DATETIME         NULL,
    [SalesOrder]        VARCHAR (100)    NOT NULL,
    [OptyId]            VARCHAR (50)     NULL,
    [PartnerId]         VARCHAR (15)     NULL,
    [CustomerId]        VARCHAR (50)     NULL,
    [CustomerName]      VARCHAR (100)    NULL,
    [CustomerPhone]     VARCHAR (50)     NULL,
    [EmailDomain]       VARCHAR (100)    NULL,
    [OrderTotal]        NUMERIC (38, 12) NULL,
    [CustomerSfdcId]    VARCHAR (50)     NULL,
    [SecondaryOppId]    VARCHAR (50)     NULL,
    [Status]            VARCHAR (5)      NULL,
    [OrderCreateStatus] VARCHAR (5)      NULL,
    [Error]             TEXT             NULL,
    [OrderType]         VARCHAR (50)     NULL,
    [PONumber]          VARCHAR (100)    NULL,
    [CustBuild]         VARCHAR (50)     NULL
);

