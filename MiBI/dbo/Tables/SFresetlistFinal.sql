CREATE TABLE [dbo].[SFresetlistFinal] (
    [ROWID]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [Created]    DATETIME       CONSTRAINT [DF_SFresetlistFinal_Created] DEFAULT (getdate()) NULL,
    [UserID]     VARCHAR (8000) NULL,
    [Contact ID] VARCHAR (8000) NULL,
    [Alias]      VARCHAR (8000) NULL,
    [First Name] VARCHAR (8000) NULL,
    [Last Name]  VARCHAR (8000) NULL,
    [Username]   VARCHAR (8000) NULL,
    [Active]     VARCHAR (8000) NULL,
    [Role]       VARCHAR (8000) NULL,
    [Last Login] VARCHAR (8000) NULL,
    [person.id]  VARCHAR (8000) NULL,
    [Status]     VARCHAR (50)   CONSTRAINT [DF_SFresetlistFinal_Status] DEFAULT ('N') NULL,
    [Error]      VARCHAR (8000) NULL,
    CONSTRAINT [PK_SFresetlistFinal] PRIMARY KEY CLUSTERED ([ROWID] ASC)
);

