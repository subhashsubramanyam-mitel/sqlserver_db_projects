﻿CREATE TABLE [PCSarchive].[AccountRateTable] (
    [Region]               NCHAR (6)      NOT NULL,
    [AccountID]            BIGINT         NULL,
    [Client Name]          NVARCHAR (255) NULL,
    [PaymentPlanOfRecord]  NVARCHAR (255) NULL,
    [Account CommRate]     FLOAT (53)     NULL,
    [PCPlanName]           NVARCHAR (50)  NULL,
    [Include Usage?]       NVARCHAR (255) NULL,
    [Crediting Partner ID] BIGINT         NULL,
    [Crediting Partner]    NVARCHAR (255) NULL,
    [SubAgentId]           NVARCHAR (128) NULL,
    [SubAgent]             NVARCHAR (512) NULL,
    [RepName]              NVARCHAR (256) NULL,
    [Notes]                NVARCHAR (255) NULL,
    [LichenAccountID]      BIGINT         NULL,
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [DateCreated]          DATETIME2 (4)  NOT NULL,
    [DateModified]         DATETIME2 (4)  NOT NULL,
    [ModifiedBy]           NVARCHAR (50)  NOT NULL
);

