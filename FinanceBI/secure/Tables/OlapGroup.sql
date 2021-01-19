CREATE TABLE [secure].[OlapGroup] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [GroupCategory] NVARCHAR (50)  NOT NULL,
    [CategoryValue] NVARCHAR (128) NOT NULL
);

