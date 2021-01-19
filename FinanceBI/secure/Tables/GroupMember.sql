CREATE TABLE [secure].[GroupMember] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [OlapUserId]  INT NOT NULL,
    [OlapGroupId] INT NOT NULL,
    CONSTRAINT [PK_GroupMember] PRIMARY KEY CLUSTERED ([Id] ASC)
);

