CREATE TABLE [support].[EmailMessage] (
    [CaseId]      VARCHAR (30)   NULL,
    [EmailId]     VARCHAR (30)   NULL,
    [TextBody]    NVARCHAR (MAX) NULL,
    [Status]      INT            NULL,
    [MessageDate] DATETIME       NULL,
    [FromAddress] VARCHAR (100)  NULL,
    [ToAddress]   VARCHAR (100)  NULL,
    [FromName]    VARCHAR (100)  NULL
);

