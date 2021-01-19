CREATE TABLE [dbo].[B_SFDC_CAMPAIGNMEMBER] (
    [Created]             DATETIME     CONSTRAINT [B_SFDC_CAMPAIGNMEMBER_1_Created] DEFAULT (getdate()) NULL,
    [Id]                  VARCHAR (20) NOT NULL,
    [CampaignId]          VARCHAR (20) NULL,
    [ContactId]           VARCHAR (20) NULL,
    [LeadId]              VARCHAR (20) NULL,
    [FirstAssociatedDate] VARCHAR (50) NULL,
    CONSTRAINT [PK_B_SFDC_CAMPAIGNMEMBER] PRIMARY KEY CLUSTERED ([Id] ASC)
);

