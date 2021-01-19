﻿CREATE TABLE [invoice].[MatVwIncrMRRNRR_EX_2_Current] (
    [AccountId]                     INT             NULL,
    [LocationId]                    INT             NULL,
    [OrderProjectManagerId]         INT             NULL,
    [OrderCreatedByPersonId]        INT             NULL,
    [orderedById]                   INT             NULL,
    [OrderSalesPersonId]            INT             NULL,
    [Ac Team]                       NVARCHAR (32)   NULL,
    [AccountManagerId]              INT             NULL,
    [MRR Category]                  NVARCHAR (50)   NULL,
    [MRR Prev]                      NUMERIC (38, 6) NULL,
    [MRR Expected]                  NUMERIC (38, 6) NULL,
    [MRR Delta]                     NUMERIC (38, 6) NULL,
    [NRR]                           NUMERIC (38, 6) NULL,
    [CurrencyCode]                  CHAR (3)        NOT NULL,
    [MRR Prev LC]                   NUMERIC (19, 4) NULL,
    [MRR Expected LC]               NUMERIC (19, 4) NULL,
    [MRR Delta LC]                  NUMERIC (19, 4) NULL,
    [NRR LC]                        MONEY           NULL,
    [InvoiceDay]                    DATETIME        NULL,
    [InvoiceMonth]                  DATETIME        NULL,
    [ServiceId]                     INT             NULL,
    [ProductId]                     INT             NULL,
    [OrderId]                       INT             NULL,
    [OrderTypeId]                   INT             NULL,
    [Order Date Created]            DATE            NULL,
    [ServiceClassId]                INT             NOT NULL,
    [DateSvcLiveActual]             DATE            NULL,
    [ServiceStatusId]               INT             NOT NULL,
    [BillingStage]                  VARCHAR (17)    NOT NULL,
    [BookToBillDays]                FLOAT (53)      NULL,
    [Quantity]                      INT             NOT NULL,
    [DeltaQuantity]                 INT             NOT NULL,
    [QMRR]                          NUMERIC (19, 4) NULL,
    [InvoiceGroupId]                INT             NULL,
    [Loc SeatSizeSegmentId]         INT             NULL,
    [Loc PlannedSeatSizeSegmentId]  INT             NULL,
    [Ac SeatSizeSegmentId]          INT             NULL,
    [Ac PlannedSeatSizeSegmentId]   INT             NULL,
    [Ac PrevMonthSeatSizeSegmentId] INT             NULL,
    [SfdcTerritoryId]               VARCHAR (50)    COLLATE Latin1_General_BIN NULL,
    [SalesContractId]               INT             NULL,
    [DeltaQuantity_Seats]           INT             NULL,
    [Quantity_Seats]                INT             NULL
);

