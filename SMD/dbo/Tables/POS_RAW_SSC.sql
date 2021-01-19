﻿CREATE TABLE [dbo].[POS_RAW_SSC] (
    [Created]        DATETIME        CONSTRAINT [DF_POS_RAW_SSC_Created] DEFAULT (getdate()) NOT NULL,
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [Invoice]        VARCHAR (100)   NULL,
    [VADId]          VARCHAR (15)    CONSTRAINT [DF_POS_RAW_SSC_VAD_ID] DEFAULT ((51746)) NOT NULL,
    [InvoiceDate]    DATETIME        NULL,
    [SalesOrder]     VARCHAR (100)   NULL,
    [CustomerPO]     VARCHAR (100)   NULL,
    [PartnerId]      VARCHAR (50)    NULL,
    [PartnerName]    VARCHAR (100)   NULL,
    [CustomerId]     VARCHAR (50)    NULL,
    [CustomerName]   VARCHAR (100)   NULL,
    [Sku]            VARCHAR (50)    NULL,
    [Qty]            DECIMAL (18, 2) NULL,
    [Billings]       DECIMAL (18, 2) NULL,
    [ShipPostalCode] VARCHAR (50)    NULL,
    [LeadId]         VARCHAR (50)    NULL,
    [ShipCity]       VARCHAR (100)   NULL,
    [ShipState]      VARCHAR (100)   NULL,
    [ShipCountry]    VARCHAR (100)   CONSTRAINT [DF_POS_RAW_SSC_ShipCountry] DEFAULT ('US') NULL,
    CONSTRAINT [PK_POS_RAW_SSC] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[POS_RAW_SSC] TO [POS]
    AS [dbo];

