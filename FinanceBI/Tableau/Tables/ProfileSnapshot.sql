CREATE TABLE [Tableau].[ProfileSnapshot] (
    [Id]            BIGINT          IDENTITY (1, 1) NOT NULL,
    [ReportDate]    DATETIME        CONSTRAINT [DF_ProfileSnapshot_ReportDate] DEFAULT (getdate()) NOT NULL,
    [AccountId]     INT             NULL,
    [AccountName]   NVARCHAR (4000) NULL,
    [AccountNumber] NVARCHAR (50)   NOT NULL,
    [DefaultPIN]    NVARCHAR (5)    NULL,
    [ProfileId]     INT             NOT NULL,
    [ProfileTypeId] INT             NOT NULL,
    [ProfileType]   NVARCHAR (20)   NOT NULL,
    [ProfileName]   NVARCHAR (4000) NULL,
    [TnId]          VARCHAR (15)    NULL,
    [Instance]      NVARCHAR (100)  NULL,
    [PersonId]      VARCHAR (30)    NOT NULL,
    [EmailAddress]  NVARCHAR (4000) NULL,
    [ValidEmail]    INT             NOT NULL,
    [FirstName]     NVARCHAR (4000) NULL,
    [LastName]      NVARCHAR (4000) NULL,
    CONSTRAINT [PK_ProfileSnapshot] PRIMARY KEY CLUSTERED ([Id] ASC)
);

