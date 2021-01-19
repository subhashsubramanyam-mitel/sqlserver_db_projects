CREATE TABLE [sfdc].[SkyCase] (
    [Created]          DATETIME      NULL,
    [LastModified]     DATETIME      NULL,
    [SfdcId]           VARCHAR (50)  NOT NULL,
    [AccountName]      VARCHAR (MAX) NULL,
    [CaseNumber]       VARCHAR (50)  NULL,
    [CaseOwnerRole]    VARCHAR (500) NULL,
    [Reason]           VARCHAR (500) NULL,
    [NumberOfCases]    NUMERIC (18)  NULL,
    [AccountId]        VARCHAR (50)  NULL,
    [SfdcCreateDate]   DATETIME      NULL,
    [SfdcModifiedDate] DATETIME      NULL,
    [M5dbAccountId]    VARCHAR (50)  NULL,
    [CaseOrigin]       VARCHAR (500) NULL,
    CONSTRAINT [PK_SkyCase] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

