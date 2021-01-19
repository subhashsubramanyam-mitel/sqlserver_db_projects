﻿CREATE TABLE [dbo].[SkySFDCServiceNow] (
    [Created]               DATETIME      CONSTRAINT [DF_SkySFDCServiceNow_Created] DEFAULT (getdate()) NOT NULL,
    [Number]                VARCHAR (100) NOT NULL,
    [Systems]               VARCHAR (100) NULL,
    [ITSMType]              VARCHAR (100) NULL,
    [u_category]            VARCHAR (100) NULL,
    [State]                 VARCHAR (100) NULL,
    [UsersImpacted]         VARCHAR (100) NULL,
    [TrustSite]             VARCHAR (10)  NULL,
    [NumberOfEndpoint]      VARCHAR (100) NULL,
    [short_description]     VARCHAR (500) NULL,
    [StartDateTime]         DATETIME      NULL,
    [EndDateTime]           DATETIME      NULL,
    [NotificationNotNeeded] VARCHAR (10)  NULL,
    [NotificationSent]      VARCHAR (10)  NULL,
    [AllClearSent]          VARCHAR (10)  NULL,
    [Description]           VARCHAR (500) NULL,
    [InternalSummary]       VARCHAR (100) NULL,
    [JepCode]               VARCHAR (100) NULL,
    [TechTeam]              VARCHAR (100) NULL,
    [TechTower]             VARCHAR (100) NULL,
    [Applications]          VARCHAR (100) NULL,
    [IncidentBySystem]      VARCHAR (100) NULL,
    [IncidentType]          VARCHAR (100) NULL,
    [RallyDefect]           VARCHAR (100) NULL,
    [u_carrier_responsible] VARCHAR (100) NULL,
    [u_hardware_type]       VARCHAR (100) NULL,
    [u_duration_in_seconds] VARCHAR (100) NULL,
    [u_inbound_impact]      VARCHAR (100) NULL,
    [u_outbound_impact]     VARCHAR (100) NULL,
    [u_portal_impact]       VARCHAR (100) NULL,
    [u_scc_impact]          VARCHAR (100) NULL,
    [u_task_number]         VARCHAR (100) NULL,
    [u_created_date_time]   DATETIME      NULL,
    [u_public]              VARCHAR (50)  NULL,
    [u_task_updates]        VARCHAR (500) NULL,
    [ITSMSfId]              VARCHAR (50)  NULL,
    [ITSMUpdateSfId]        VARCHAR (50)  NULL,
    [ITSMCaseNumber]        VARCHAR (50)  NULL,
    [ErrorMsg]              VARCHAR (255) NULL,
    CONSTRAINT [PK_SkySFDCServiceNow] PRIMARY KEY CLUSTERED ([Number] ASC)
);
