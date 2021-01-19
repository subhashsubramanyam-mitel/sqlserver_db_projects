﻿CREATE TABLE [ALSandbox].[ChurnMetrics] (
    [Account ID]         INT             NOT NULL,
    [Date]               DATE            NOT NULL,
    [Account Name]       NVARCHAR (100)  NULL,
    [Is Active]          BIT             NULL,
    [Credit Risk]        VARCHAR (11)    NULL,
    [Industry]           NVARCHAR (100)  NULL,
    [SubIndustry]        NVARCHAR (100)  NULL,
    [Platform]           NVARCHAR (20)   NULL,
    [Instance]           NCHAR (100)     NULL,
    [Age]                INT             NULL,
    [CC]                 INT             NULL,
    [Ported Numbers]     INT             NULL,
    [Active Seats]       FLOAT (53)      NULL,
    [6M SG]              FLOAT (53)      NULL,
    [12M SG]             FLOAT (53)      NULL,
    [renewautomatically] BIT             NULL,
    [termmonths]         INT             NULL,
    [months left]        INT             NULL,
    [L6MMinDown]         INT             NULL,
    [L6MAUMD]            INT             NULL,
    [L6MACCUMD]          INT             NULL,
    [Total Users]        FLOAT (53)      NULL,
    [CC Users]           FLOAT (53)      NULL,
    [L6M Outage Count]   INT             NULL,
    [Min NPS]            INT             NULL,
    [Prev NPS]           INT             NULL,
    [CSAT Min]           INT             NULL,
    [CSAT Avg]           INT             NULL,
    [FCR Percent]        NUMERIC (38, 6) NULL,
    [SLA Percent]        FLOAT (53)      NULL,
    [Cum Case Count]     INT             NULL,
    [ARS Count]          INT             NULL,
    [MRR]                FLOAT (53)      NULL,
    [6M MRR GR]          FLOAT (53)      NULL,
    [12M MRR GR]         FLOAT (53)      NULL,
    [12M Credits]        FLOAT (53)      NULL,
    [6M Credits]         FLOAT (53)      NULL,
    [MRR % Contract]     FLOAT (53)      NULL,
    [Seat Price]         FLOAT (53)      NULL,
    [PercentOnNet]       FLOAT (53)      NULL,
    [Churn]              INT             NOT NULL
);
