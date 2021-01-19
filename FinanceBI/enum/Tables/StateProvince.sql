CREATE TABLE [enum].[StateProvince] (
    [Id]         INT            NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    [CountryId]  INT            NOT NULL,
    [CodeAlpha]  NVARCHAR (10)  NOT NULL,
    [CodeAlphaX] NVARCHAR (30)  NULL,
    CONSTRAINT [PK_DimStateProvince] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_StateProvince_Country] FOREIGN KEY ([CountryId]) REFERENCES [enum].[Country] ([Id])
);

