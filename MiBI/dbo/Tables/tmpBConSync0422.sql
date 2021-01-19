CREATE TABLE [dbo].[tmpBConSync0422] (
    [Id]     CHAR (10)   NOT NULL,
    [Status] VARCHAR (1) CONSTRAINT [DF_tmpBConSync0422_Status] DEFAULT ('N') NOT NULL,
    [Error]  TEXT        NULL,
    CONSTRAINT [PK_tmpBConSync0422] PRIMARY KEY CLUSTERED ([Id] ASC)
);

