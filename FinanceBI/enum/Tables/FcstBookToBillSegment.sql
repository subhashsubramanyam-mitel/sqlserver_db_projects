CREATE TABLE [enum].[FcstBookToBillSegment] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Low]  FLOAT (53)    NOT NULL,
    [High] FLOAT (53)    NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_BookToBillSegment] PRIMARY KEY CLUSTERED ([Id] ASC)
);

