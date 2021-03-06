﻿CREATE TABLE [dbo].[SKY_SFDC_SERVICES] (
    [Created]             DATETIME       CONSTRAINT [DF_SKY_SFDC_SERVICES_Created] DEFAULT (getdate()) NULL,
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [CiId]                VARCHAR (50)   NOT NULL,
    [M5DBServiceId]       FLOAT (53)     NULL,
    [ServiceId]           NVARCHAR (255) NULL,
    [LichenServiceId]     FLOAT (53)     NULL,
    [Accountid]           NVARCHAR (255) NULL,
    [LocationId]          NVARCHAR (255) NULL,
    [Class]               NVARCHAR (255) NULL,
    [Name]                VARCHAR (255)  NULL,
    [Status]              NVARCHAR (255) NULL,
    [OrderId]             FLOAT (53)     NULL,
    [Invoiced]            FLOAT (53)     NULL,
    [MRR]                 FLOAT (53)     NULL,
    [NRC]                 FLOAT (53)     NULL,
    [ProductId]           FLOAT (53)     NULL,
    [DateCreatedOriginal] VARCHAR (50)   NULL,
    [DateFoc]             VARCHAR (50)   NULL,
    [DateLiveActual]      VARCHAR (50)   NULL,
    [DateClosed]          VARCHAR (50)   NULL,
    [DateBillingStart]    VARCHAR (50)   NULL,
    [DateBillingStopped]  VARCHAR (50)   NULL,
    [DateOrdered]         VARCHAR (50)   NULL,
    [CloseOrderId]        FLOAT (53)     NULL,
    [CarrierName]         NVARCHAR (255) NULL,
    [CarrierId]           NVARCHAR (255) NULL,
    [LastModifiedBy]      NVARCHAR (255) NULL,
    [Owner]               NVARCHAR (255) NULL,
    [M5DBAccountId]       NVARCHAR (255) NULL,
    [M5DBCompanyId]       NVARCHAR (255) NULL,
    [ForecastDate]        VARCHAR (50)   NULL,
    [ErrStatus]           CHAR (1)       CONSTRAINT [DF_SKY_SFDC_SERVICES_ErrStatus] DEFAULT ('N') NULL,
    [ErrorTxt]            TEXT           NULL,
    CONSTRAINT [PK_SKY_SFDC_SERVICES] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SKY_SFDC_SERVICES] TO [SKY_SFDC]
    AS [dbo];

