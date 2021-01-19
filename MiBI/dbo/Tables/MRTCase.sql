CREATE TABLE [dbo].[MRTCase] (
    [ID]                    VARCHAR (50)  NOT NULL,
    [CreatedBy]             VARCHAR (500) NULL,
    [CreatedByID]           VARCHAR (100) NULL,
    [CreatedDate]           DATETIME      NULL,
    [CriticaltoResolveCase] VARCHAR (50)  NULL,
    [LastModifiedBy]        VARCHAR (500) NULL,
    [LastModifiedByID]      VARCHAR (100) NULL,
    [LastModifiedDate]      DATETIME      NULL,
    [Name]                  VARCHAR (500) NULL,
    [RelatedCaseID]         VARCHAR (50)  NULL,
    [RelatedMRTID]          VARCHAR (50)  NULL,
    [Status]                VARCHAR (50)  NULL,
    CONSTRAINT [PK_MRTCase] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[MRTCase] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MRTCase] TO [Reporting]
    AS [dbo];

