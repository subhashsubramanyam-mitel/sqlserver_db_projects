CREATE TABLE [dbo].[LMS_CERTS_RAW] (
    [Id]               VARCHAR (50)  NULL,
    [ImpactNumber]     VARCHAR (50)  NULL,
    [Email]            VARCHAR (100) NULL,
    [CertCode]         VARCHAR (100) CONSTRAINT [DF_LMS_CERTS_RAW_CertCode] DEFAULT ('InvalidCode') NOT NULL,
    [CourseDesc]       VARCHAR (200) NULL,
    [CompleteDate]     VARCHAR (50)  NULL,
    [SubscriptionDate] VARCHAR (50)  NULL,
    [SessionStartDate] VARCHAR (50)  NULL,
    [FirstName]        VARCHAR (50)  NULL,
    [LastName]         VARCHAR (50)  NULL,
    [EmployeeNumber]   VARCHAR (50)  NULL,
    [Status]           VARCHAR (50)  CONSTRAINT [DF_LMS_CERTS_RAW_Status] DEFAULT ('N') NULL
);

