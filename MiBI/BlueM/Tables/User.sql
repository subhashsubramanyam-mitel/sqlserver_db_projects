CREATE TABLE [BlueM].[User] (
    [Id]               VARCHAR (20)  NOT NULL,
    [ContactId]        VARCHAR (20)  NULL,
    [IsActive]         BIT           NULL,
    [CreatedDate]      DATETIME      NULL,
    [Department]       VARCHAR (80)  NULL,
    [Email]            VARCHAR (128) NULL,
    [FirstName]        VARCHAR (80)  NULL,
    [LastModifiedDate] DATETIME      NULL,
    [LastName]         VARCHAR (80)  NULL,
    [Username]         VARCHAR (80)  NULL,
    [Name]             VARCHAR (121) NULL,
    [Title]            VARCHAR (80)  NULL,
    [UserRoleId]       VARCHAR (18)  NULL,
    [AccountId]        VARCHAR (20)  NULL,
    [ProfileId]        VARCHAR (20)  NULL,
    [Phone]            VARCHAR (40)  NULL,
    [ManagerId]        VARCHAR (20)  NULL,
    [Extension]        VARCHAR (40)  NULL,
    CONSTRAINT [PK_blue_User] PRIMARY KEY CLUSTERED ([Id] ASC)
);

