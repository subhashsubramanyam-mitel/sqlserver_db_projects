CREATE TABLE [dbo].[SkySFDCAccount_EU] (
    [Created]          DATETIME        CONSTRAINT [DF_SkySFDCAccount_EU_Created] DEFAULT (getdate()) NOT NULL,
    [AccountId]        VARCHAR (50)    NOT NULL,
    [CompanyId]        VARCHAR (50)    NOT NULL,
    [CompanyName]      VARCHAR (500)   NULL,
    [AccountStatusId]  VARCHAR (50)    NULL,
    [AccountStatus]    VARCHAR (50)    NULL,
    [AccountManagerId] VARCHAR (50)    NULL,
    [AccountManager]   VARCHAR (50)    NULL,
    [AccountTeamId]    VARCHAR (50)    NULL,
    [AccountTeam]      VARCHAR (50)    NULL,
    [ClusterId]        VARCHAR (50)    NULL,
    [ClusterName]      VARCHAR (50)    NULL,
    [ActiveMRR]        DECIMAL (18, 2) NULL,
    [SfId]             VARCHAR (50)    NULL,
    [Status]           VARCHAR (10)    CONSTRAINT [DF_SkySFDCAccount_EU_Status] DEFAULT ('N') NULL,
    [ErrMsg]           VARCHAR (500)   NULL,
    [FirstInvoice]     DATETIME        NULL,
    [ProfileCount]     VARCHAR (15)    CONSTRAINT [DF_SkySFDCAccount_EU_ProfileCount] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SkySFDCAccount_EU] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);

