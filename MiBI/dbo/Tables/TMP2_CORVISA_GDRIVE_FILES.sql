CREATE TABLE [dbo].[TMP2_CORVISA_GDRIVE_FILES] (
    [Created]     DATETIME      NULL,
    [FileId]      VARCHAR (200) NOT NULL,
    [FolderId]    VARCHAR (200) NULL,
    [TopFolderId] VARCHAR (200) NULL,
    [OppId]       VARCHAR (50)  NULL,
    [FileName]    VARCHAR (200) NULL,
    [FileType]    VARCHAR (200) NULL,
    [Size]        FLOAT (53)    NULL,
    [Status]      VARCHAR (5)   NULL,
    [Error]       TEXT          NULL
);

