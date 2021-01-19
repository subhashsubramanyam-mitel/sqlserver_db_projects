CREATE TABLE [secure].[OlapUser] (
    [Id]              INT            IDENTITY (1, 1) NOT NULL,
    [Username]        NVARCHAR (64)  NOT NULL,
    [UserDescription] NVARCHAR (128) NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id] ASC)
);

