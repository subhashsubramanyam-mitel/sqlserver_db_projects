CREATE TABLE [dbo].[TrainingActivity] (
    [ROWID]            INT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate]      DATETIME      CONSTRAINT [DF_TrainingActivityTrk_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [SfdcId]           VARCHAR (50)  NULL,
    [EmployeeNum]      VARCHAR (50)  NULL,
    [ImpactNumber]     VARCHAR (50)  NULL,
    [CompanyName]      VARCHAR (255) NULL,
    [FirstName]        VARCHAR (255) NULL,
    [LastName]         VARCHAR (255) NULL,
    [Email]            VARCHAR (255) NULL,
    [VendorName]       VARCHAR (255) NULL,
    [StatusDesc]       VARCHAR (255) NULL,
    [Completed]        DATETIME      NULL,
    [Audience]         VARCHAR (255) NULL,
    [SubscriptionDate] DATETIME      NULL,
    [SessionStartDate] DATETIME      NULL,
    [Status]           CHAR (1)      NULL,
    [Error]            VARCHAR (MAX) NULL,
    [LastModified]     DATETIME      NULL,
    CONSTRAINT [PK_TrainingActivityTrk] PRIMARY KEY CLUSTERED ([ROWID] ASC)
);

