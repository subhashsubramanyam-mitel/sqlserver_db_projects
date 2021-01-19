CREATE TABLE [company].[AccountCluster] (
    [Id]             INT NOT NULL,
    [AccountId]      INT NOT NULL,
    [ClusterId]      INT NOT NULL,
    [PrimaryCluster] BIT NOT NULL,
    CONSTRAINT [PK_AccountCluster] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AccountCluster_Account] FOREIGN KEY ([AccountId]) REFERENCES [company].[Account] ([Id]),
    CONSTRAINT [FK_AccountCluster_Cluster] FOREIGN KEY ([ClusterId]) REFERENCES [enum].[Cluster] ([Id])
);

