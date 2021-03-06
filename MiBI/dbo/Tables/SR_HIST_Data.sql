﻿CREATE TABLE [dbo].[SR_HIST_Data] (
    [Id]                     INT           IDENTITY (1, 1) NOT NULL,
    [Created]                DATETIME      CONSTRAINT [DF_SR_HIST1_Created_1] DEFAULT (getdate()) NULL,
    [Sdate]                  DATETIME      NULL,
    [theDay]                 VARCHAR (10)  NULL,
    [theMonth]               VARCHAR (10)  NULL,
    [theYear]                SMALLINT      NULL,
    [DayOfMonth]             SMALLINT      NULL,
    [WeekOfYear]             SMALLINT      NULL,
    [MonthOfYear]            SMALLINT      NULL,
    [QuarterOfYear]          VARCHAR (2)   NULL,
    [FQuarter]               VARCHAR (15)  NULL,
    [CaseNumber]             VARCHAR (50)  NULL,
    [Subject]                VARCHAR (MAX) NULL,
    [ParterSTID]             VARCHAR (50)  NULL,
    [PartnerOfRecord]        VARCHAR (500) NULL,
    [EndUserSTID]            VARCHAR (50)  NULL,
    [EndUser]                VARCHAR (500) NULL,
    [ActiveServiceAgreement] VARCHAR (500) NULL,
    [Area]                   VARCHAR (500) NULL,
    [RootCause]              VARCHAR (MAX) NULL,
    [CaseOwner]              VARCHAR (50)  NULL,
    [CreatedDate]            DATETIME      NOT NULL,
    [ClosedDate]             DATETIME      NULL,
    [CommitDate]             DATETIME      NULL,
    [Version]                VARCHAR (100) NULL,
    [Phase]                  VARCHAR (100) NULL,
    [CaseOrigin]             VARCHAR (100) NULL,
    [Feature]                VARCHAR (100) NULL,
    [Priority]               VARCHAR (100) NULL,
    [Status]                 VARCHAR (50)  NULL,
    [SubStatus]              VARCHAR (50)  NULL,
    [ContactName]            VARCHAR (500) NULL,
    [ContactEmail]           VARCHAR (500) NULL,
    [LastModifiedDate]       DATETIME      NOT NULL,
    [VADSTID]                VARCHAR (50)  NULL,
    [VADNam]                 VARCHAR (500) NULL,
    [SLAFlag]                VARCHAR (50)  NULL,
    [LastSLAUpdateTACAgent]  DATETIME      NULL,
    [DaysToSLA]              VARCHAR (50)  NULL,
    [MilestoneStatus]        VARCHAR (50)  NULL,
    [NextMilestoneDueDate]   DATETIME      NULL,
    [CaseOwnerRole]          VARCHAR (500) NULL,
    [RecordTypeName]         VARCHAR (500) NULL,
    [MilestoneIcon]          VARCHAR (500) NULL,
    [Region]                 VARCHAR (50)  NULL,
    [Theater]                VARCHAR (100) NULL,
    CONSTRAINT [PK_SR_HIST1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SR_HIST1]
    ON [dbo].[SR_HIST_Data]([CaseNumber] ASC);

