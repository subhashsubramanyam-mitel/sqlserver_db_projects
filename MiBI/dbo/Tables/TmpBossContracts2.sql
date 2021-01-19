CREATE TABLE [dbo].[TmpBossContracts2] (
    [ContractId]             INT         NOT NULL,
    [AccountId]              INT         NOT NULL,
    [ContractTypeId]         INT         NOT NULL,
    [StartDate]              CHAR (10)   NULL,
    [TermMonths]             INT         NOT NULL,
    [EndDate]                CHAR (10)   NULL,
    [MRR]                    MONEY       NOT NULL,
    [RenewAutomatically]     BIT         NOT NULL,
    [BusinessTermVersion]    INT         NOT NULL,
    [ProfileAmount]          INT         NOT NULL,
    [DownturnPercentage]     INT         NOT NULL,
    [EarlyTerminationFee]    MONEY       NOT NULL,
    [InstallEnforcementDate] CHAR (10)   NULL,
    [InstallPeriod]          VARCHAR (7) NULL,
    [InitialCreationDate]    CHAR (10)   NULL
);

