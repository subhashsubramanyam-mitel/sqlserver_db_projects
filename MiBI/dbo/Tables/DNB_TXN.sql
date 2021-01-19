CREATE TABLE [dbo].[DNB_TXN] (
    [Created] DATETIME     CONSTRAINT [DF_DNB_TXN_Created] DEFAULT (getdate()) NOT NULL,
    [Id]      VARCHAR (15) NOT NULL,
    [LeadId]  VARCHAR (50) NULL,
    [Message] TEXT         NOT NULL,
    [Status]  CHAR (1)     CONSTRAINT [DF_DNB_TXN_Status] DEFAULT ('N') NOT NULL,
    CONSTRAINT [PK_DNB_TXN] PRIMARY KEY CLUSTERED ([Id] ASC)
);

