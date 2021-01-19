CREATE TABLE [dbo].[DefectManagement] (
    [ID]                      VARCHAR (50)   NOT NULL,
    [EngEngageNum]            VARCHAR (254)  NULL,
    [Abstract]                VARCHAR (MAX)  NULL,
    [AdditionalNotify1ID]     VARCHAR (500)  NULL,
    [AdditionalNotify2ID]     VARCHAR (500)  NULL,
    [AdditionalNotify3ID]     VARCHAR (500)  NULL,
    [AdditionalNotify4ID]     VARCHAR (500)  NULL,
    [Area]                    VARCHAR (500)  NULL,
    [Attachments]             VARCHAR (500)  NULL,
    [Automation]              VARCHAR (500)  NULL,
    [Build]                   VARCHAR (500)  NULL,
    [BuildID]                 VARCHAR (500)  NULL,
    [Challenge]               VARCHAR (500)  NULL,
    [CreatedBy]               VARCHAR (500)  NULL,
    [CreatedByID]             VARCHAR (500)  NULL,
    [CreatedByRole]           VARCHAR (500)  NULL,
    [CreatedDate]             DATETIME       NULL,
    [CriticalAccount]         VARCHAR (500)  NULL,
    [DefectStatus]            VARCHAR (500)  NULL,
    [Developer]               VARCHAR (500)  NULL,
    [DeveloperID]             VARCHAR (500)  NULL,
    [EngGroup]                VARCHAR (500)  NULL,
    [ExtendedDescription]     VARCHAR (MAX)  NULL,
    [FieldChallenge]          VARCHAR (500)  NULL,
    [FieldIssues]             VARCHAR (500)  NULL,
    [FoundID]                 VARCHAR (500)  NULL,
    [FoundName]               VARCHAR (500)  NULL,
    [FoundVia]                VARCHAR (500)  NULL,
    [Keywords]                VARCHAR (MAX)  NULL,
    [LastModifiedBy]          VARCHAR (500)  NULL,
    [LastModifiedByID]        VARCHAR (500)  NULL,
    [LastModifiedDate]        DATETIME       NULL,
    [MigratedFrom]            VARCHAR (500)  NULL,
    [OpenMRTs]                VARCHAR (500)  NULL,
    [Priority]                VARCHAR (500)  NULL,
    [QAOwner]                 VARCHAR (500)  NULL,
    [QAOwnerID]               VARCHAR (500)  NULL,
    [Reason]                  VARCHAR (500)  NULL,
    [RecordTypeID]            VARCHAR (500)  NULL,
    [RelatedCaseID]           VARCHAR (500)  NULL,
    [ResolutionDescription]   VARCHAR (MAX)  NULL,
    [ResolvedMRTs]            VARCHAR (500)  NULL,
    [SEDefectNum]             VARCHAR (500)  NULL,
    [Severity]                VARCHAR (500)  NULL,
    [SubArea]                 VARCHAR (500)  NULL,
    [SubStatus]               VARCHAR (500)  NULL,
    [TestCases]               VARCHAR (MAX)  NULL,
    [TotalMRTs]               VARCHAR (500)  NULL,
    [Type]                    VARCHAR (500)  NULL,
    [Version]                 VARCHAR (500)  NULL,
    [WorkOrder]               VARCHAR (500)  NULL,
    [DefectName]              VARCHAR (300)  NULL,
    [ParentProject]           VARCHAR (300)  NULL,
    [EstimatedResolutionDate] VARCHAR (50)   NULL,
    [Blocker]                 VARCHAR (100)  NULL,
    [Blocked]                 VARCHAR (100)  NULL,
    [BlockedReason]           VARCHAR (4000) NULL,
    [NumberofCases]           VARCHAR (50)   NULL,
    [UserStoryID]             VARCHAR (100)  NULL,
    [Feature]                 VARCHAR (100)  NULL,
    [BetaBlocker]             VARCHAR (50)   NULL,
    [Reviewed]                VARCHAR (50)   NULL,
    [DeploymentType]          VARCHAR (50)   NULL,
    [ClusterInformation]      VARCHAR (50)   NULL,
    CONSTRAINT [PK_DefectManagement] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DefectManagement] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DefectManagement] TO [Reporting]
    AS [dbo];

