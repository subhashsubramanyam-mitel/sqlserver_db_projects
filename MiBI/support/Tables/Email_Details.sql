CREATE TABLE [support].[Email_Details] (
    [CaseNumber]     VARCHAR (50)   NULL,
    [CaseId]         VARCHAR (50)   NULL,
    [EmailId]        VARCHAR (50)   NULL,
    [Status]         VARCHAR (50)   NULL,
    [MessageDate]    DATETIME       NULL,
    [FromName]       VARCHAR (250)  NULL,
    [FromAddress]    VARCHAR (250)  NULL,
    [ToAddress]      NVARCHAR (MAX) NULL,
    [Incoming]       VARCHAR (20)   NULL,
    [EmailSentiment] DECIMAL (5, 2) NULL,
    [EmailMagnitude] DECIMAL (5, 2) NULL,
    [EmailEmotion]   VARCHAR (50)   NULL,
    [IsCustomer]     VARCHAR (10)   NULL
);

