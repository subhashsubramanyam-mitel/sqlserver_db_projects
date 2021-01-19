CREATE TABLE [dbo].[CE_SVY_URI] (
    [Created] DATETIME      CONSTRAINT [DF_CE_SVY_URI_Created] DEFAULT (getdate()) NOT NULL,
    [URI]     VARCHAR (100) NULL,
    [SvyId]   VARCHAR (50)  NULL
);

