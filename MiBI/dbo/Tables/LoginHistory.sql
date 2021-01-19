CREATE TABLE [dbo].[LoginHistory] (
    [ID]        VARCHAR (50)  NOT NULL,
    [UserId]    VARCHAR (50)  NULL,
    [LoginTime] DATETIME      NULL,
    [LoginUrl]  VARCHAR (500) NULL,
    [NetworkId] VARCHAR (50)  NULL,
    [Status]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_LoginHistory] PRIMARY KEY CLUSTERED ([ID] ASC)
);

