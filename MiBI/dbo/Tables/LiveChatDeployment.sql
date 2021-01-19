CREATE TABLE [dbo].[LiveChatDeployment] (
    [LiveChatDeploymentId]   VARCHAR (18)   NOT NULL,
    [LiveChatDeploymentName] NVARCHAR (240) NULL,
    [HasTranscriptSave]      BIT            NULL,
    [IsDeleted]              BIT            NULL,
    [CreatedById]            VARCHAR (50)   NULL,
    [CreatedDate]            DATETIME       NULL,
    [LastModifiedById]       VARCHAR (50)   NULL,
    [LastModifiedDate]       DATETIME       NULL,
    CONSTRAINT [PK_LiveChatDeployment] PRIMARY KEY CLUSTERED ([LiveChatDeploymentId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[LiveChatDeployment] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LiveChatDeployment] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LiveChatDeployment] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LiveChatDeployment] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[LiveChatDeployment] TO [TACECC]
    AS [dbo];

