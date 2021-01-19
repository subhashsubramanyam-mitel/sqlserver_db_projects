CREATE TABLE [people].[AccessRoleMember] (
    [Id]            INT NOT NULL,
    [RoleId]        INT NOT NULL,
    [PersonId]      INT NULL,
    [GroupId]       INT NULL,
    [AccountId]     INT NULL,
    [LocationId]    INT NULL,
    [TargetGroupId] INT NULL,
    CONSTRAINT [PK_AccessRoleMember] PRIMARY KEY CLUSTERED ([Id] ASC)
);

