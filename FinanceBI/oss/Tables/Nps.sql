CREATE TABLE [oss].[Nps] (
    [Id]              INT  IDENTITY (1, 1) NOT NULL,
    [Date]            DATE NOT NULL,
    [Referencability] INT  NOT NULL,
    [AccountId]       INT  NOT NULL,
    [DateScored]      DATE NULL,
    CONSTRAINT [PK_FactNps] PRIMARY KEY CLUSTERED ([Id] ASC)
);

