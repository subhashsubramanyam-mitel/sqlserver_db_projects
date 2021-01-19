CREATE TABLE [dbo].[SFDC_PROPOSAL] (
    [Created]         DATETIME      CONSTRAINT [DF_SFDC_PROPOSAL_Created] DEFAULT (getdate()) NULL,
    [Id]              VARCHAR (25)  NOT NULL,
    [CreatedDate]     DATETIME      NULL,
    [PrimaryCheckbox] VARCHAR (5)   NULL,
    [ProposalId]      VARCHAR (10)  NULL,
    [Promotion]       VARCHAR (255) NULL,
    [OpportunityId]   VARCHAR (25)  NULL,
    CONSTRAINT [PK_SFDC_PROPOSAL] PRIMARY KEY CLUSTERED ([Id] ASC)
);

