CREATE TABLE [company].[Account] (
    [Id]                    INT            NOT NULL,
    [Name]                  NVARCHAR (100) NOT NULL,
    [Number]                NVARCHAR (50)  NOT NULL,
    [CompanyTypeId]         INT            NOT NULL,
    [CompanySalesChannelId] INT            NOT NULL,
    [AccountCategoryId]     INT            NOT NULL,
    [AccountSubCategoryId]  INT            NOT NULL,
    [PrimaryClusterId]      INT            NULL,
    [OutDialDigit]          CHAR (1)       CONSTRAINT [DF_Account_OutDialDigit] DEFAULT ('9') NOT NULL,
    [IsActive]              BIT            CONSTRAINT [DF_Account_IsActive] DEFAULT ((1)) NOT NULL,
    [ParentAccountId]       INT            NULL,
    [LichenAccountId]       INT            CONSTRAINT [DF_Account_LichenAccountId] DEFAULT ((-1)) NULL,
    [PartnerId]             INT            NULL,
    [IsHybrid]              BIT            CONSTRAINT [DF_Account_IsHybrid] DEFAULT ((0)) NOT NULL,
    [DeployEnvId]           INT            NULL,
    [NativeOid]             INT            NULL,
    CONSTRAINT [PK_DimAccount] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Account_Account] FOREIGN KEY ([ParentAccountId]) REFERENCES [company].[Account] ([Id]),
    CONSTRAINT [FK_Account_AccountAttr] FOREIGN KEY ([Id]) REFERENCES [company].[AccountAttr] ([AccountId]),
    CONSTRAINT [FK_Account_AccountCategory] FOREIGN KEY ([AccountCategoryId]) REFERENCES [enum].[AccountCategory] ([Id]),
    CONSTRAINT [FK_Account_AccountSubCategory] FOREIGN KEY ([AccountSubCategoryId]) REFERENCES [enum].[AccountSubCategory] ([Id]),
    CONSTRAINT [FK_Account_Cluster] FOREIGN KEY ([PrimaryClusterId]) REFERENCES [enum].[Cluster] ([Id]),
    CONSTRAINT [FK_Account_CompanyType] FOREIGN KEY ([CompanyTypeId]) REFERENCES [enum].[CompanyType] ([Id]),
    CONSTRAINT [FK_Account_SalesChannel] FOREIGN KEY ([CompanySalesChannelId]) REFERENCES [enum].[SalesChannel] ([Id])
);


GO
ALTER TABLE [company].[Account] NOCHECK CONSTRAINT [FK_Account_Account];


GO
ALTER TABLE [company].[Account] NOCHECK CONSTRAINT [FK_Account_AccountAttr];


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170521-044715]
    ON [company].[Account]([LichenAccountId] ASC);

