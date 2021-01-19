CREATE TABLE [enum].[Country] (
    [Id]         INT            NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    [CodeAlpha2] CHAR (2)       NOT NULL,
    [CodeAlpha3] CHAR (3)       NOT NULL,
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([Id] ASC)
);

