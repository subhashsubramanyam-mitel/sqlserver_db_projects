CREATE TABLE [enum].[MRRValueCategory] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DimMRRValueCategory] PRIMARY KEY CLUSTERED ([Id] ASC)
);

