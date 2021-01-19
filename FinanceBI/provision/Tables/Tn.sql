CREATE TABLE [provision].[Tn] (
    [Id]           NVARCHAR (15)  NOT NULL,
    [CountryId]    INT            NOT NULL,
    [TnTypeId]     INT            NULL,
    [AccountId]    INT            NULL,
    [LocationId]   INT            NULL,
    [ProfileId]    INT            NULL,
    [Label]        NVARCHAR (100) NULL,
    [TrunkGroupId] INT            NULL,
    [TnStatusId]   INT            NULL,
    CONSTRAINT [PK_DimTn2] PRIMARY KEY CLUSTERED ([Id] ASC, [CountryId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Label]
    ON [provision].[Tn]([Label] ASC);

