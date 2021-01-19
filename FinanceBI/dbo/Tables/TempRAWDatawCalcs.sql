﻿CREATE TABLE [dbo].[TempRAWDatawCalcs] (
    [lichenpartnerid]          FLOAT (53)     NULL,
    [Partnername]              NVARCHAR (255) NULL,
    [LichenAccountId]          FLOAT (53)     NULL,
    [clientname]               NVARCHAR (255) NULL,
    [lichenlocationid]         FLOAT (53)     NULL,
    [serviceID]                FLOAT (53)     NULL,
    [chargetype]               NVARCHAR (255) NULL,
    [charge]                   FLOAT (53)     NULL,
    [Description]              NVARCHAR (255) NULL,
    [CreditExclude]            NVARCHAR (255) NULL,
    [UsageIncl]                NVARCHAR (255) NULL,
    [AccountChange]            NVARCHAR (255) NULL,
    [Account CommRate]         FLOAT (53)     NULL,
    [LocationChange]           NVARCHAR (255) NULL,
    [Location CommRate]        FLOAT (53)     NULL,
    [ServiceChange]            NVARCHAR (255) NULL,
    [Service CommRate]         FLOAT (53)     NULL,
    [Adjusted LichenPartnerID] FLOAT (53)     NULL,
    [Adjusted Partner Name]    NVARCHAR (255) NULL,
    [Partner CommRate]         FLOAT (53)     NULL,
    [Adjusted Charge]          MONEY          NULL,
    [CommRate]                 FLOAT (53)     NULL,
    [Payout]                   MONEY          NULL
);

