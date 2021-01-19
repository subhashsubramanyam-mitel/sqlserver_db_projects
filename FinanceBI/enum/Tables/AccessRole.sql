CREATE TABLE [enum].[AccessRole] (
    [Id]       INT             NOT NULL,
    [RoleName] NVARCHAR (1024) NOT NULL,
    CONSTRAINT [PK_AccessRole] PRIMARY KEY CLUSTERED ([Id] ASC)
);

