CREATE TABLE [dbo].[B_SFDC_CAMPAIGNS] (
    [Created]         DATETIME      CONSTRAINT [DF_B_SFDC_CAMPAIGNS_Created] DEFAULT (getdate()) NULL,
    [Id]              VARCHAR (50)  NOT NULL,
    [ActivityType]    VARCHAR (50)  NULL,
    [CampaignSource]  VARCHAR (50)  NULL,
    [CustomerSegment] VARCHAR (50)  NULL,
    [Name]            VARCHAR (200) NULL,
    [ParentId]        VARCHAR (50)  NULL,
    [ProductSuite]    VARCHAR (50)  NULL,
    [Status]          VARCHAR (50)  NULL,
    [Team]            VARCHAR (150) NULL,
    [Type]            VARCHAR (50)  NULL,
    CONSTRAINT [PK_B_SFDC_CAMPAIGNS] PRIMARY KEY CLUSTERED ([Id] ASC)
);

