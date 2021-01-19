CREATE TABLE [cdr].[BadTN] (
    [Id]           NVARCHAR (32)  NOT NULL,
    [CountryId]    INT            NOT NULL,
    [TnTypeId]     INT            NULL,
    [AccountId]    INT            NULL,
    [LocationId]   INT            NULL,
    [ProfileId]    INT            NULL,
    [Label]        NVARCHAR (100) NULL,
    [TrunkGroupId] INT            NULL
);

