CREATE TABLE [dbo].[ARS] (
    [ID]                     VARCHAR (50)  NOT NULL,
    [AccountID]              VARCHAR (500) NULL,
    [ARSCount]               VARCHAR (500) NULL,
    [ARSID]                  VARCHAR (50)  NULL,
    [AtRiskNow]              VARCHAR (50)  NULL,
    [CreatedBy]              VARCHAR (500) NULL,
    [CreatedByID]            VARCHAR (50)  NULL,
    [CreatedDate]            DATETIME      NULL,
    [DateLost]               DATETIME      NULL,
    [DateSaved]              DATETIME      NULL,
    [EffectiveMRRChangeDate] DATETIME      NULL,
    [LastModifiedBy]         VARCHAR (500) NULL,
    [LastModifiedByID]       VARCHAR (50)  NULL,
    [LastModifiedDate]       DATETIME      NULL,
    [M5DBAccountId]          VARCHAR (50)  NULL,
    [PendingMRRChange]       VARCHAR (500) NULL,
    [RootCausePrimary]       VARCHAR (500) NULL,
    [RootCauseSecondary]     VARCHAR (500) NULL,
    [RootCauseTertiary]      VARCHAR (500) NULL,
    [Status]                 VARCHAR (500) NULL,
    [TriggerField]           VARCHAR (MAX) NULL,
    [WeeklyUpdate]           VARCHAR (MAX) NULL,
    [RelatedProduct]         VARCHAR (100) NULL,
    [Description]            VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ARS] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ARS] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ARS] TO [Reporting]
    AS [dbo];

