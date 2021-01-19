CREATE TABLE [dbo].[Users] (
    [ID]                    VARCHAR (50)  NOT NULL,
    [Active]                VARCHAR (50)  NULL,
    [ContactId]             VARCHAR (50)  NULL,
    [CreatedDate]           DATETIME      NULL,
    [Department]            VARCHAR (500) NULL,
    [Email]                 VARCHAR (500) NULL,
    [FirstName]             VARCHAR (500) NULL,
    [LastName]              VARCHAR (500) NULL,
    [LastModifiedDate]      DATETIME      NULL,
    [Name]                  VARCHAR (500) NULL,
    [Title]                 VARCHAR (500) NULL,
    [Username]              VARCHAR (500) NULL,
    [RoleName]              VARCHAR (500) NULL,
    [BmAccessType]          VARCHAR (500) NULL,
    [BmAsscToOrg]           VARCHAR (500) NULL,
    [BmDelAppr]             VARCHAR (500) NULL,
    [BmLogin]               VARCHAR (50)  NULL,
    [AccountId]             VARCHAR (50)  NULL,
    [AccountName]           VARCHAR (500) NULL,
    [AccountPartnerCoLogin] VARCHAR (50)  NULL,
    [ProfileId]             VARCHAR (50)  NULL,
    [ProfileName]           VARCHAR (500) NULL,
    [UserLicenseId]         VARCHAR (50)  NULL,
    [Phone]                 VARCHAR (50)  NULL,
    [ManagerId]             VARCHAR (25)  NULL,
    [BossPersonId]          VARCHAR (25)  NULL,
    [Extension]             VARCHAR (25)  NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_Users_AccountId]
    ON [dbo].[Users]([AccountId] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[Users] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Users] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Users] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Users] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\AMohandas]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\brobison]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\aneuman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\alossing]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\MBrondum]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\dorr]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [CANDY\beswanson]
    AS [dbo];

