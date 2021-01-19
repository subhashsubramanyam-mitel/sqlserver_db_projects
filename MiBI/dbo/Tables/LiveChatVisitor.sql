CREATE TABLE [dbo].[LiveChatVisitor] (
    [LiveChatVisitorId]   VARCHAR (18)  NOT NULL,
    [LiveChatVisitorName] VARCHAR (255) NULL,
    [IsDeleted]           BIT           NULL,
    [CreatedById]         VARCHAR (50)  NULL,
    [CreatedDate]         DATETIME      NULL,
    [LastModifiedById]    VARCHAR (50)  NULL,
    [LastModifiedDate]    DATETIME      NULL,
    CONSTRAINT [PK_LiveChatVisitor] PRIMARY KEY CLUSTERED ([LiveChatVisitorId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[LiveChatVisitor] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LiveChatVisitor] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LiveChatVisitor] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LiveChatVisitor] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[LiveChatVisitor] TO [TACECC]
    AS [dbo];

