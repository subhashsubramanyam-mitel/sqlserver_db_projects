﻿CREATE TABLE [dbo].[SFDC_OPTY_TRK] (
    [Created]           DATETIME         CONSTRAINT [DF_SFDC_OPTY_TRK_Created] DEFAULT (getdate()) NULL,
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
    [Status]            VARCHAR (5)      CONSTRAINT [DF_SFDC_OPTY_TRK_Status] DEFAULT ('N') NULL,
    [OrderCreateStatus] VARCHAR (5)      CONSTRAINT [DF_SFDC_OPTY_TRK_OrderCreateStatus] DEFAULT ('N') NULL,
    [Error]             TEXT             NULL,
    [OrderType]         VARCHAR (50)     NULL,
    [PONumber]          VARCHAR (100)    NULL,
    [CustBuild]         VARCHAR (50)     NULL,
    CONSTRAINT [PK_SFDC_OPTY_TRK] PRIMARY KEY CLUSTERED ([SalesOrder] ASC)
);
