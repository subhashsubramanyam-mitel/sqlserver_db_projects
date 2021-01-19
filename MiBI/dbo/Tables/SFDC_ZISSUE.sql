CREATE TABLE [dbo].[SFDC_ZISSUE] (
    [Created]      DATETIME       CONSTRAINT [DF_SFDC_ZISSUE_Created] DEFAULT (getdate()) NULL,
    [Id]           VARCHAR (25)   NOT NULL,
    [FixVersions]  NVARCHAR (255) NULL,
    [IssueKey]     NVARCHAR (255) NULL,
    [IssueType]    NVARCHAR (255) NULL,
    [Priority]     NVARCHAR (255) NULL,
    [Resolution]   NVARCHAR (255) NULL,
    [Status]       NVARCHAR (255) NULL,
    [Summary]      NVARCHAR (255) NULL,
    [LastUpdated]  DATETIME       NULL,
    [ResolvedDate] DATETIME       NULL,
    CONSTRAINT [PK_SFDC_ZISSUE] PRIMARY KEY CLUSTERED ([Id] ASC)
);

