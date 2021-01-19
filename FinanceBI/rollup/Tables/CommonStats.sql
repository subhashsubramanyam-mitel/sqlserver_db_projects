CREATE TABLE [rollup].[CommonStats] (
    [Id]                                   INT   IDENTITY (1, 1) NOT NULL,
    [SvcMonth]                             DATE  NULL,
    [NumProfiles]                          INT   CONSTRAINT [DF_CommonStats_NumProfiles] DEFAULT ((0)) NOT NULL,
    [NumCircuits]                          INT   CONSTRAINT [DF_CommonStats_NumCircuits] DEFAULT ((0)) NOT NULL,
    [NumSupportCasesRegular]               INT   CONSTRAINT [DF_CommonStats_NumSupportCasesRegular] DEFAULT ((0)) NOT NULL,
    [NumSupportCasesOutage]                INT   CONSTRAINT [DF_CommonStats_NumNocCasesInScope] DEFAULT ((0)) NOT NULL,
    [NumSupportCasesNoAccount]             INT   CONSTRAINT [DF_CommonStats_NumSupportCasesNoAccount] DEFAULT ((0)) NOT NULL,
    [NumNocCasesTotal]                     INT   CONSTRAINT [DF_CommonStats_NumNocCasesTotal] DEFAULT ((0)) NOT NULL,
    [NumNocCasesOutage]                    INT   CONSTRAINT [DF_CommonStats_NumNocCasesOutage] DEFAULT ((0)) NOT NULL,
    [NumNocCasesNoAccount]                 INT   CONSTRAINT [DF_CommonStats_NumNocCasesNoAccount] DEFAULT ((0)) NOT NULL,
    [CostPerSupportCase]                   MONEY CONSTRAINT [DF_CommonStats_CostPerSupportCase] DEFAULT ((0)) NOT NULL,
    [CostPerNocSupportCase]                MONEY CONSTRAINT [DF_CommonStats_CostPerNocSupportCase] DEFAULT ((0)) NOT NULL,
    [CostPerNocConnectivityMonitoringCase] MONEY CONSTRAINT [DF_CommonStats_CostPerNocConnectivityMonitoringCase] DEFAULT ((0)) NOT NULL,
    [CostPerProfile]                       MONEY CONSTRAINT [DF_CommonStats_CostPerProfile] DEFAULT ((0.0)) NULL,
    [CostProfileInfra]                     MONEY CONSTRAINT [DF_CommonStats_CostProfileInfra] DEFAULT ((0)) NOT NULL,
    [CostProfileInfraPerProfile]           MONEY CONSTRAINT [DF_CommonStats_CostProfileInfraPerProfile] DEFAULT ((0)) NOT NULL,
    [CostProfileOvhd]                      MONEY CONSTRAINT [DF_CommonStats_CostProfileOvhd] DEFAULT ((0)) NOT NULL,
    [CostProfileOvhdPerProfile]            MONEY CONSTRAINT [DF_CommonStats_CostProfileOvhdPerProfile] DEFAULT ((0)) NOT NULL,
    [CostAccessInfra]                      MONEY CONSTRAINT [DF_CommonStats_CostAccessInfra] DEFAULT ((0)) NOT NULL,
    [CostAccessInfraPerCircuit]            MONEY CONSTRAINT [DF_CommonStats_CostAccessInfraPerCircuit] DEFAULT ((0)) NOT NULL,
    [CostAcctMgmtPerProfile]               MONEY CONSTRAINT [DF_CommonStats_CostAcctMgmtPerProfile] DEFAULT ((0)) NOT NULL,
    [CostAccessOvhdPerCircuit]             MONEY CONSTRAINT [DF_CommonStats_CostAccessOvhdPerCircuit] DEFAULT ((0.0)) NOT NULL,
    CONSTRAINT [PK_CommonStats] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170510-100446]
    ON [rollup].[CommonStats]([SvcMonth] ASC);

