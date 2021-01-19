CREATE TABLE [dbo].[OPP_AUDIT] (
    [Created]  DATETIME      CONSTRAINT [DF_OPP_AUDIT_Created] DEFAULT (getdate()) NULL,
    [OptyId]   VARCHAR (50)  NULL,
    [UserName] VARCHAR (100) NULL
);

