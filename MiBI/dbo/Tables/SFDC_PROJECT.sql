CREATE TABLE [dbo].[SFDC_PROJECT] (
    [Created]                   DATETIME      CONSTRAINT [DF_SFDC_PROJECT_Created] DEFAULT (getdate()) NULL,
    [ProjectId]                 VARCHAR (50)  NOT NULL,
    [OppId]                     VARCHAR (50)  NULL,
    [ProjectOwnerName]          VARCHAR (250) NULL,
    [ProjectStartDate]          DATETIME      NULL,
    [ProjectTargetCompleteDate] DATETIME      NULL,
    [ProjectStatus]             VARCHAR (50)  NULL,
    [ProjectPctComplete]        VARCHAR (50)  NULL,
    [OAProjectId]               VARCHAR (50)  NULL,
    [ProjectOwnerId]            VARCHAR (50)  NULL,
    [DelayReason]               VARCHAR (255) NULL,
    [DelayDescription]          VARCHAR (255) NULL,
    CONSTRAINT [PK_SFDC_PROJECT] PRIMARY KEY CLUSTERED ([ProjectId] ASC)
);

