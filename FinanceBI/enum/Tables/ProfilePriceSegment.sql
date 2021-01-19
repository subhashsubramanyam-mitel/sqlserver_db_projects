CREATE TABLE [enum].[ProfilePriceSegment] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Low]  INT           NOT NULL,
    [High] INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL
);

