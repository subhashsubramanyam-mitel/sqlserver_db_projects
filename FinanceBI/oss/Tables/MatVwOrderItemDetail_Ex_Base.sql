﻿CREATE TABLE [oss].[MatVwOrderItemDetail_Ex_Base] (
    [OrderItemId]               INT             NOT NULL,
    [OrderId]                   INT             NOT NULL,
    [OrderItemType]             NVARCHAR (50)   NOT NULL,
    [OrderItemTypeId]           INT             NOT NULL,
    [Description]               NVARCHAR (256)  NULL,
    [Quantity]                  INT             NULL,
    [ServiceId]                 INT             NULL,
    [ProductId]                 INT             NULL,
    [DateEffective]             DATE            NULL,
    [DateProcessed]             DATE            NULL,
    [ServiceClassId]            INT             NULL,
    [NewMRR]                    NUMERIC (38, 6) NULL,
    [NewNRC]                    NUMERIC (38, 6) NULL,
    [PrevMRR]                   NUMERIC (38, 6) NULL,
    [PrevNRC]                   NUMERIC (38, 6) NULL,
    [DeltaMRR]                  NUMERIC (38, 6) NULL,
    [DeltaNRC]                  NUMERIC (38, 6) NULL,
    [CurrencyCode]              CHAR (3)        NOT NULL,
    [NewMRR_LC]                 MONEY           NULL,
    [NewNRC_LC]                 MONEY           NULL,
    [PrevMRR_LC]                MONEY           NULL,
    [PrevNRC_LC]                MONEY           NULL,
    [DeltaMRR_LC]               MONEY           NULL,
    [DeltaNRC_LC]               MONEY           NULL,
    [NewPPPId]                  INT             NULL,
    [PrevPPPId]                 INT             NULL,
    [InvoiceGroupId]            INT             NULL,
    [InvoiceServiceGroupId]     INT             NULL,
    [LocationId]                INT             NULL,
    [InvoiceLabel]              NVARCHAR (100)  NULL,
    [CircuitCarrierCompanyId]   INT             NULL,
    [OrderLocationId]           INT             NULL,
    [OrderAccountid]            INT             NOT NULL,
    [DateLiveScheduledOriginal] DATE            NULL,
    [DateLiveScheduled]         DATE            NULL,
    [DateBillingStart]          DATE            NULL,
    [DateBillingStopped]        DATE            NULL,
    [OrderTypeId]               INT             NOT NULL,
    [OrderedById]               INT             NULL,
    [ProjectManagerId]          INT             NULL,
    [SalesPersonId]             INT             NULL,
    [CreatedByPersonId]         INT             NULL,
    [ModifiedByPersonId]        INT             NULL,
    [DateCreated]               DATE            NULL,
    [ServiceStatusId]           INT             NULL,
    [MasterOrderTypeId]         INT             NULL
);

