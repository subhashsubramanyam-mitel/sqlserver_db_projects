CREATE TABLE [dbo].[CaseDefect] (
    [ID]               VARCHAR (50)  NOT NULL,
    [CaseID]           VARCHAR (50)  NOT NULL,
    [CaseNumber]       NCHAR (10)    NULL,
    [CreatedBy]        VARCHAR (500) NULL,
    [CreatedByID]      VARCHAR (100) NULL,
    [CreatedDate]      DATETIME      NULL,
    [Defect]           VARCHAR (50)  NOT NULL,
    [DefectNumber]     NCHAR (10)    NULL,
    [LastModifiedBy]   VARCHAR (500) NULL,
    [LastModifiedByID] VARCHAR (100) NULL,
    [LastModifiedDate] DATETIME      NULL,
    [LinktoDefect]     VARCHAR (100) NULL,
    [Name]             VARCHAR (500) NULL,
    CONSTRAINT [PK_CaseDefect] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseDefect_CaseID]
    ON [dbo].[CaseDefect]([CaseID] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_CaseDefect_Defect]
    ON [dbo].[CaseDefect]([Defect] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CaseDefect] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CaseDefect] TO [Reporting]
    AS [dbo];

