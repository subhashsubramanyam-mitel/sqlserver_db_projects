CREATE TABLE [cdr].[Connect_OverageCharge_Schema] (
    [PartyGroupId]      BIGINT         NOT NULL,
    [ClusterId]         INT            NOT NULL,
    [ProfileId]         INT            NOT NULL,
    [ProfileName]       NVARCHAR (128) NOT NULL,
    [ProfileType]       NVARCHAR (20)  NOT NULL,
    [AccountId]         INT            NOT NULL,
    [LocationId]        INT            NOT NULL,
    [TimeStart]         DATETIME       NOT NULL,
    [TimeEnd]           DATETIME       NOT NULL,
    [TnCountryCode]     VARCHAR (4)    NULL,
    [Tn]                NVARCHAR (64)  NOT NULL,
    [TargetCountryCode] VARCHAR (4)    NULL,
    [TargetTn]          NVARCHAR (64)  NOT NULL,
    [UsageRegionId]     INT            NOT NULL,
    [RoundedDuration]   INT            NOT NULL,
    [ChargeInDollars]   MONEY          NOT NULL
);

