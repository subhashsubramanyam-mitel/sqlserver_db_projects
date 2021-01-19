CREATE TABLE [enum].[SeatSizeSegment] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Low]  INT           NOT NULL,
    [High] INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DimSeatSizeSegment] PRIMARY KEY CLUSTERED ([Id] ASC)
);

