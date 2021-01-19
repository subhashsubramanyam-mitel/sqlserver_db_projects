CREATE TABLE [enum].[AccountSubCategory] (
    [Id]                INT            NOT NULL,
    [Name]              NVARCHAR (100) NOT NULL,
    [AccountCategoryId] INT            NULL,
    CONSTRAINT [PK_AccountSubCategory] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AccountSubCategory_AccountCategory] FOREIGN KEY ([AccountCategoryId]) REFERENCES [enum].[AccountCategory] ([Id])
);

