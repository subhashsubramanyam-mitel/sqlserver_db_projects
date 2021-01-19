CREATE TABLE [enum].[PlatformType] (
    [Id]   INT           NOT NULL,
    [Name] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_DimPlatformType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

