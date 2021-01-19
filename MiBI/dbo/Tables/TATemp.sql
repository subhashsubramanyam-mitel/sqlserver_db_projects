CREATE TABLE [dbo].[TATemp] (
    [ID]                VARCHAR (50)  NOT NULL,
    [TrainingActivity]  VARCHAR (500) NULL,
    [CompleteDate]      DATETIME      NULL,
    [Contact]           VARCHAR (500) NULL,
    [ContactEmail]      VARCHAR (50)  NULL,
    [CourseCode]        VARCHAR (50)  NULL,
    [CourseDescription] VARCHAR (50)  NULL,
    [CourseType]        VARCHAR (500) NULL,
    [CreatedByID]       VARCHAR (50)  NULL,
    [CreatedDate]       DATETIME      NULL,
    [LastModifiedByID]  VARCHAR (50)  NULL,
    [LastModifiedDate]  DATETIME      NULL,
    [SessionStartDate]  DATETIME      NULL,
    [Status]            VARCHAR (500) NULL,
    [SubscriptionDate]  DATETIME      NULL,
    [TempID]            VARCHAR (500) NULL,
    CONSTRAINT [PK_TATemp] PRIMARY KEY CLUSTERED ([ID] ASC)
);

