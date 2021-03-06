﻿CREATE TABLE [tmp].[m5db_Circuit_Circuit] (
    [Id]                  INT             NOT NULL,
    [Name]                NVARCHAR (255)  NULL,
    [TunnelNum]           INT             NULL,
    [CircuitTypeId]       INT             NOT NULL,
    [MPLSTypeId]          INT             NULL,
    [CircuitUsageTypeId]  INT             NULL,
    [CircuitCapacity]     NVARCHAR (32)   NULL,
    [ServiceId]           INT             NULL,
    [DateFOC]             DATETIME2 (4)   NULL,
    [DateOrdered]         DATETIME2 (4)   NULL,
    [CarrierOrderNumber]  NVARCHAR (50)   NULL,
    [CarrierAccountId]    INT             NULL,
    [SiteContactPersonid] INT             NULL,
    [Demarc]              NVARCHAR (1024) NULL,
    [DateDemarcExtn]      DATETIME2 (4)   NULL,
    [WanIP]               VARCHAR (32)    NULL,
    [DateInstalled]       DATETIME2 (4)   NULL,
    [CPERouterId]         INT             NULL,
    [ConfirmedTested]     BIT             NULL,
    [Monitor]             BIT             NOT NULL,
    [MonitorComment]      NVARCHAR (128)  NULL,
    [DateLive]            DATETIME2 (4)   NULL,
    [DateCancelled]       DATETIME2 (4)   NULL,
    [CancelConfirmation]  NVARCHAR (50)   NULL,
    [DateModified]        DATETIME2 (4)   NOT NULL,
    [DateCreated]         DATETIME2 (4)   NOT NULL,
    [ModifiedBy]          NVARCHAR (50)   NOT NULL,
    [RecordVersion]       ROWVERSION      NOT NULL,
    [CircuitStatusId]     INT             NOT NULL,
    [CircuitBTN]          NVARCHAR (32)   NULL,
    [LecCircuitId]        NVARCHAR (128)  NULL
);

