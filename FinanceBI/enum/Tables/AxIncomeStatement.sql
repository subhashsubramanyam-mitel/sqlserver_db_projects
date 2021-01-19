CREATE TABLE [enum].[AxIncomeStatement] (
    [Id]        NVARCHAR (131) NOT NULL,
    [IS Level1] NVARCHAR (64)  NULL,
    [IS Level2] NVARCHAR (64)  NULL,
    CONSTRAINT [PK_AxIncomeStatement] PRIMARY KEY CLUSTERED ([Id] ASC)
);

