CREATE TABLE [dbo].[Skill] (
    [SkillId]          VARCHAR (18)   NOT NULL,
    [SkillName]        NVARCHAR (240) NULL,
    [CreatedById]      VARCHAR (50)   NULL,
    [CreatedDate]      DATETIME       NULL,
    [LastModifiedById] VARCHAR (50)   NULL,
    [LastModifiedDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([SkillId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[Skill] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Skill] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Skill] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Skill] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Skill] TO [TACECC]
    AS [dbo];

