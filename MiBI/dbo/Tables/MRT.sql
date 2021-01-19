CREATE TABLE [dbo].[MRT] (
    [ID]                VARCHAR (50)   NOT NULL,
    [ChangeList]        VARCHAR (500)  NULL,
    [CorrectedInID]     VARCHAR (500)  NULL,
    [CreatedBy]         VARCHAR (500)  NULL,
    [CreatedByID]       VARCHAR (500)  NULL,
    [CreatedDate]       DATETIME       NULL,
    [DefectID]          VARCHAR (500)  NULL,
    [DefectAbstract]    VARCHAR (500)  NULL,
    [DeliveryVehicle]   VARCHAR (500)  NULL,
    [DueDate]           DATETIME       NULL,
    [Effort]            VARCHAR (500)  NULL,
    [InKnowledgeBase]   VARCHAR (500)  NULL,
    [LastModifiedBy]    VARCHAR (500)  NULL,
    [LastModifiedByID]  VARCHAR (500)  NULL,
    [LastModifiedDate]  DATETIME       NULL,
    [MRTName]           VARCHAR (500)  NULL,
    [QAAQAC]            VARCHAR (500)  NULL,
    [RecordTypeID]      VARCHAR (500)  NULL,
    [RejectedDate]      DATETIME       NULL,
    [RelatedCases]      VARCHAR (500)  NULL,
    [ResolvedDate]      DATETIME       NULL,
    [ReviewedByID]      VARCHAR (500)  NULL,
    [ReviewedDate]      DATETIME       NULL,
    [Risk]              VARCHAR (500)  NULL,
    [SEDefectNum]       VARCHAR (500)  NULL,
    [Status]            VARCHAR (500)  NULL,
    [SubStatus]         VARCHAR (500)  NULL,
    [TargetID]          VARCHAR (500)  NULL,
    [TestEngineer]      VARCHAR (500)  NULL,
    [TestEngineeremail] VARCHAR (500)  NULL,
    [VerifiedDate]      DATETIME       NULL,
    [VerifiedIn]        VARCHAR (500)  NULL,
    [PatchedIn]         VARCHAR (2000) NULL,
    [ClosedDate]        VARCHAR (50)   NULL,
    [RejectedReason]    VARCHAR (4000) NULL,
    [CorrectedInName]   VARCHAR (100)  NULL,
    [CreatedByFullName] VARCHAR (100)  NULL,
    CONSTRAINT [PK_MRT] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[MRT] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MRT] TO [Reporting]
    AS [dbo];

