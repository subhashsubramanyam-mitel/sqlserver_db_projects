CREATE TABLE [audit].[mVwTnProfile] (
    [TN]                               VARCHAR (15)   NOT NULL,
    [TnStatus]                         NVARCHAR (30)  NULL,
    [TnAccountId]                      INT            NULL,
    [TnAccountPrimaryClusterId]        INT            NULL,
    [IsTnMainNumber]                   INT            NULL,
    [RedirectTn]                       VARCHAR (15)   NULL,
    [TrunkGroupId]                     INT            NULL,
    [Carrier]                          NVARCHAR (100) NULL,
    [ProfileId]                        INT            NULL,
    [ProfileTypeId]                    INT            NULL,
    [PartitionId]                      INT            NULL,
    [DateProfileCreated]               DATETIME2 (4)  NULL,
    [ProfileType]                      NVARCHAR (20)  NOT NULL,
    [PartitionClusterId]               INT            NULL,
    [PartitionAccountId]               INT            NULL,
    [PartitionAccountPrimaryClusterId] INT            NULL
);

