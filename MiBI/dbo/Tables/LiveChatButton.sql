CREATE TABLE [dbo].[LiveChatButton] (
    [LiveChatButtonId]                 VARCHAR (18)  NOT NULL,
    [LiveChatButtonName]               VARCHAR (240) NULL,
    [CreatedById]                      VARCHAR (50)  NULL,
    [CreatedDate]                      DATETIME      NULL,
    [LastModifiedById]                 VARCHAR (50)  NULL,
    [LastModifiedDate]                 DATETIME      NULL,
    [HasQueue]                         BIT           NULL,
    [IsActive]                         BIT           NULL,
    [IsDeleted]                        BIT           NULL,
    [OptionsHasChasitorIdleTimeout]    BIT           NULL,
    [OptionsHasInviteAfterAccept]      BIT           NULL,
    [OptionsHasInviteAfterReject]      BIT           NULL,
    [OptionsHasRerouteDeclinedRequest] BIT           NULL,
    [OptionsIsAutoAccept]              BIT           NULL,
    [OptionsIsInviteAutoRemov]         BIT           NULL,
    [NumberOfReroutingAttempts]        INT           NULL,
    [PushTimeout]                      INT           NULL,
    [RoutingType]                      VARCHAR (255) NULL,
    [SkillId]                          VARCHAR (18)  NULL,
    PRIMARY KEY CLUSTERED ([LiveChatButtonId] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[LiveChatButton] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LiveChatButton] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LiveChatButton] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LiveChatButton] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[LiveChatButton] TO [TACECC]
    AS [dbo];

