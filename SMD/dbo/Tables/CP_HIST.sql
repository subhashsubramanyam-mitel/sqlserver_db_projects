CREATE TABLE [dbo].[CP_HIST] (
    [Id]                          INT            IDENTITY (1, 1) NOT NULL,
    [InstanceDayKey]              VARCHAR (50)   NULL,
    [ReportDate]                  DATETIME       CONSTRAINT [DF_CP_HIST_ReportDate] DEFAULT (getdate()) NULL,
    [DateRank]                    FLOAT (53)     NULL,
    [Instance]                    NVARCHAR (255) NULL,
    [ActiveProvisioningInstance]  NVARCHAR (255) NULL,
    [AvailableforProvisioning]    NVARCHAR (255) NULL,
    [Count]                       NVARCHAR (255) NULL,
    [CapacityStatus]              FLOAT (53)     NULL,
    [OverMaxSIP]                  FLOAT (53)     NULL,
    [OverMaxSCCP]                 FLOAT (53)     NULL,
    [AvailableforNewInstallsSIP]  FLOAT (53)     NULL,
    [AvailableforNewInstallsSCCP] FLOAT (53)     NULL,
    [1-WeekChange]                FLOAT (53)     NULL,
    [4-WeekChange]                FLOAT (53)     NULL,
    [Type]                        NVARCHAR (255) NULL,
    [OriginalType]                NVARCHAR (255) NULL,
    [PCT_SIP]                     FLOAT (53)     NULL,
    [ActiveSeatsAccounts]         FLOAT (53)     NULL,
    [ActiveSeatsSIP]              FLOAT (53)     NULL,
    [ActiveSeatsSCCP]             FLOAT (53)     NULL,
    [PendingSeats_Built]          FLOAT (53)     NULL,
    [PendingSeats_NotBuilt]       FLOAT (53)     NULL,
    [InstanceAnticipatedTotal]    FLOAT (53)     NULL,
    [StopProvisioning]            FLOAT (53)     NULL,
    [InstanceMax]                 FLOAT (53)     NULL,
    [InstanceComments]            NVARCHAR (255) NULL,
    [InstanceRegion]              VARCHAR (100)  NULL,
    [InstanceBuildSequence]       FLOAT (53)     NULL,
    CONSTRAINT [PK_CP_HIST] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CP_HIST]
    ON [dbo].[CP_HIST]([InstanceDayKey] ASC);

