CREATE TABLE [dbo].[MileStoneCalculations] (
    [ID]                       VARCHAR (50)  NOT NULL,
    [CaseID]                   VARCHAR (254) NULL,
    [CreatedBy]                VARCHAR (500) NULL,
    [CreatedByID]              VARCHAR (500) NULL,
    [CreatedDate]              DATETIME      NULL,
    [LastModifiedBy]           VARCHAR (500) NULL,
    [LastModifiedByID]         VARCHAR (500) NULL,
    [LastModifiedDate]         DATETIME      NULL,
    [MileStoneCalculationName] VARCHAR (500) NULL,
    [MilestoneType]            VARCHAR (500) NULL,
    [NextMileStoneDueDate]     DATETIME      NULL,
    [OwnerID]                  VARCHAR (500) NULL,
    CONSTRAINT [PK_MileStoneCalculations] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[MileStoneCalculations] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MileStoneCalculations] TO [Reporting]
    AS [dbo];

