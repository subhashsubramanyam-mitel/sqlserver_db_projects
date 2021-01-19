CREATE TABLE [enum].[TimeZone] (
    [Id]   INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DimTimeZone] PRIMARY KEY CLUSTERED ([Id] ASC)
);

