CREATE TABLE [dbo].[LmsSTUsers] (
    [Created]        DATETIME      CONSTRAINT [DF_LmsSTUsers_Created] DEFAULT (getdate()) NOT NULL,
    [ID]             VARCHAR (50)  NOT NULL,
    [FirstName]      VARCHAR (100) NULL,
    [LastName]       VARCHAR (100) NULL,
    [Email]          VARCHAR (100) NULL,
    [Status]         VARCHAR (15)  NULL,
    [HireDate]       DATETIME      NULL,
    [TermStatusDate] DATETIME      NULL,
    [Office]         VARCHAR (100) NULL,
    CONSTRAINT [PK_LmsSTUsers] PRIMARY KEY CLUSTERED ([ID] ASC)
);

