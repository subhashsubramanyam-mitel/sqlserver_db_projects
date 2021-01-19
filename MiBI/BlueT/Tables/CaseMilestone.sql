CREATE TABLE [BlueT].[CaseMilestone] (
    [Id]                   VARCHAR (20) NOT NULL,
    [CaseId]               VARCHAR (20) NULL,
    [CompletionDate]       DATETIME     NULL,
    [IsCompleted]          BIT          NULL,
    [IsDeleted]            BIT          NULL,
    [IsViolated]           BIT          NULL,
    [MilestoneTypeId]      VARCHAR (20) NULL,
    [TargetDate]           DATETIME     NULL,
    [TargetResponseInHrs]  FLOAT (53)   NULL,
    [TimeRemainingInHrs]   FLOAT (53)   NULL,
    [TimeSinceTargetInHrs] FLOAT (53)   NULL,
    [CreatedById]          VARCHAR (20) NULL,
    [CreatedDate]          DATETIME     NULL,
    [LastModifiedById]     VARCHAR (20) NULL,
    [LastModifiedDate]     DATETIME     NULL,
    CONSTRAINT [PK_blue_CaseMilestone] PRIMARY KEY CLUSTERED ([Id] ASC)
);

