CREATE TABLE [enum].[Cluster] (
    [Id]             INT         NOT NULL,
    [Name]           NCHAR (100) NOT NULL,
    [PlatformTypeId] INT         NOT NULL,
    CONSTRAINT [PK_Cluster] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Cluster_PlatformType] FOREIGN KEY ([PlatformTypeId]) REFERENCES [enum].[PlatformType] ([Id])
);

