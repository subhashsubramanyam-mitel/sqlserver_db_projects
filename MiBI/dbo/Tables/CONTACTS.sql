CREATE TABLE [dbo].[CONTACTS] (
    [SfdcId]                VARCHAR (50)  NOT NULL,
    [ContactId]             VARCHAR (50)  NULL,
    [AccountId]             VARCHAR (50)  NULL,
    [SfdcAccountId]         VARCHAR (50)  NULL,
    [AccountSTID]           VARCHAR (50)  NULL,
    [CsatContact]           CHAR (1)      NULL,
    [CorpSpnsr]             CHAR (1)      NULL,
    [FName]                 VARCHAR (100) NULL,
    [LName]                 VARCHAR (100) NULL,
    [JobTitle]              VARCHAR (150) NULL,
    [Email]                 VARCHAR (150) NULL,
    [WorkPhone]             VARCHAR (50)  NULL,
    [ContactPin]            VARCHAR (50)  NULL,
    [EmailFlag]             CHAR (1)      NULL,
    [PrimaryContactID]      VARCHAR (50)  NULL,
    [Active]                VARCHAR (50)  NULL,
    [SecurityRoles]         VARCHAR (500) NULL,
    [Created]               DATETIME      CONSTRAINT [DF_CONTACTS2_Created] DEFAULT (getdate()) NULL,
    [SfdcCreateDateUTC]     DATETIME      NULL,
    [SfdcLastUpdateDateUTC] DATETIME      NULL,
    [AccessLevel]           VARCHAR (50)  NULL,
    [PersonId]              VARCHAR (50)  NULL,
    [BOSSContactRole]       VARCHAR (100) NULL,
    [BOSSPhone]             VARCHAR (50)  NULL,
    [LmsOptOut]             VARCHAR (50)  NULL,
    [MobilePhone]           VARCHAR (50)  NULL,
    [CustomerSupportPIN__c] VARCHAR (15)  NULL,
    [VARECertified__c]      VARCHAR (5)   NULL,
    CONSTRAINT [PK_CONTACTS2_2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CONTACTS] TO [TacEngRole]
    AS [dbo];

