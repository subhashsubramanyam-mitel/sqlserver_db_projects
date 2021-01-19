CREATE TABLE [dbo].[Group] (
    [GroupId]                VARCHAR (18)   NOT NULL,
    [GroupName]              NVARCHAR (120) NULL,
    [OwnerId]                VARCHAR (18)   NULL,
    [GroupEmail]             VARCHAR (255)  NULL,
    [CreatedById]            VARCHAR (50)   NULL,
    [CreatedDate]            DATETIME       NULL,
    [LastModifiedById]       VARCHAR (50)   NULL,
    [LastModifiedDate]       DATETIME       NULL,
    [DoesIncludeBosses]      BIT            NULL,
    [DoesSendEmailToMembers] BIT            NULL,
    CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED ([GroupId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[Group] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Group] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Group] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Group] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Group] TO [TACECC]
    AS [dbo];

