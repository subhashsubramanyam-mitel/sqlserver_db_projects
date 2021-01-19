CREATE TABLE [dbo].[CaseMilestone] (
    [Id]               VARCHAR (50)  NOT NULL,
    [CaseId]           VARCHAR (254) NULL,
    [Completed]        VARCHAR (50)  NULL,
    [CompletionDate]   DATETIME      NULL,
    [CreatedDate]      DATETIME      NULL,
    [LastModifiedDate] DATETIME      NULL,
    [MilestoneName]    VARCHAR (500) NULL,
    [TargetDate]       DATETIME      NULL,
    [TimeRemaining]    VARCHAR (50)  NULL,
    [Violation]        VARCHAR (50)  NULL,
    CONSTRAINT [PK_CaseMilestone] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseMilestone_Completed]
    ON [dbo].[CaseMilestone]([Completed] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseMilestone_Violation]
    ON [dbo].[CaseMilestone]([Violation] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseMilestone_CaseId]
    ON [dbo].[CaseMilestone]([CaseId] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseMilestone_CreatedDate]
    ON [dbo].[CaseMilestone]([CreatedDate] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CaseMilestone] TO [TacEngRole]
    AS [dbo];

