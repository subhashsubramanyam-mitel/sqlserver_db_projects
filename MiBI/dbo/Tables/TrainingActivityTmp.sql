CREATE TABLE [dbo].[TrainingActivityTmp] (
    [ROWID]            INT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate]      DATETIME      CONSTRAINT [DF_TrainingActivityTmp_CreatedDate] DEFAULT (getdate()) NOT NULL,
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
    [CertId]           VARCHAR (500) NULL,
    CONSTRAINT [PK_TrainingActivityTmp] PRIMARY KEY CLUSTERED ([ROWID] ASC)
);

