CREATE TABLE [dbo].[RelatedDefect] (
    [ID]                VARCHAR (50)  NOT NULL,
    [CreatedBy]         VARCHAR (500) NULL,
    [CreatedByID]       VARCHAR (500) NULL,
    [CreatedDate]       DATETIME      NULL,
    [DefectID]          VARCHAR (500) NULL,
    [DefectName]        VARCHAR (500) NULL,
    [LastModifiedBy]    VARCHAR (500) NULL,
    [LastModifiedByID]  VARCHAR (500) NULL,
    [LastModifiedDate]  DATETIME      NULL,
    [OwnerId]           VARCHAR (500) NULL,
    [OwnerName]         VARCHAR (500) NULL,
    [RelatedDefect]     VARCHAR (500) NULL,
    [RelatedDefectName] VARCHAR (500) NULL,
    CONSTRAINT [PK_RelatedDefect] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RelatedDefect] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RelatedDefect] TO [Reporting]
    AS [dbo];

