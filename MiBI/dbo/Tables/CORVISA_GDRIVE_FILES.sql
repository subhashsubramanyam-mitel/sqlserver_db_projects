﻿CREATE TABLE [dbo].[CORVISA_GDRIVE_FILES] (
    [Created]     DATETIME      CONSTRAINT [DF_CORVISA_GDRIVE_FILES_Created] DEFAULT (getdate()) NULL,
    [FileId]      VARCHAR (200) NOT NULL,
    [FolderId]    VARCHAR (200) NULL,
    [TopFolderId] VARCHAR (200) NULL,
    [OppId]       VARCHAR (50)  NULL,
    [FileName]    VARCHAR (200) NULL,
    [FileType]    VARCHAR (200) NULL,
    [Size]        FLOAT (53)    CONSTRAINT [DF_CORVISA_GDRIVE_FILES_Size] DEFAULT ((0)) NULL,
    [Status]      VARCHAR (5)   CONSTRAINT [DF_CORVISA_GDRIVE_FILES_Status] DEFAULT ('N') NULL,
    [Error]       TEXT          NULL,
    CONSTRAINT [PK_CORVISA_GDRIVE_FILES] PRIMARY KEY CLUSTERED ([FileId] ASC)
);

