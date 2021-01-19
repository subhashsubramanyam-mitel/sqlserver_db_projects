CREATE TABLE [dbo].[LMS_CERTS_TEST] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [ImpactNumber] CHAR (20)     NOT NULL,
    [Email]        VARCHAR (70)  NOT NULL,
    [CertCode]     VARCHAR (100) NOT NULL,
    [CompleteDate] DATETIME      NULL,
    [FirstName]    VARCHAR (50)  NULL,
    [LastName]     VARCHAR (50)  NULL,
    [NewCertFlg]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_LMS_CERTS_TEST] PRIMARY KEY CLUSTERED ([Id] ASC)
);

