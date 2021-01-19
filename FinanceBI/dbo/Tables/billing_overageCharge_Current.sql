CREATE TABLE [dbo].[billing_overageCharge_Current] (
    [id]               BIGINT         NOT NULL,
    [profileId]        INT            NOT NULL,
    [profileName]      NVARCHAR (128) NOT NULL,
    [profileType]      NVARCHAR (20)  NOT NULL,
    [LichenAccountId]  INT            NOT NULL,
    [LichenLocationId] INT            NOT NULL,
    [start]            DATETIME       NOT NULL,
    [endTs]            DATETIME       NOT NULL,
    [tn]               NVARCHAR (15)  NOT NULL,
    [orig]             VARCHAR (15)   NOT NULL,
    [UsageRegionId]    INT            NOT NULL,
    [roundedDuration]  INT            NOT NULL,
    [chargeInDollars]  FLOAT (53)     NOT NULL
);

