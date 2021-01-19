CREATE TABLE [ALSandbox].[SvcAvailabilityCustomer] (
    [AccountId]         INT          NULL,
    [Platform]          VARCHAR (32) NULL,
    [LDVS]              VARCHAR (32) NULL,
    [CC Num]            VARCHAR (32) NULL,
    [Instance]          VARCHAR (32) NULL,
    [Outage Type]       VARCHAR (32) NULL,
    [Outage Date]       DATETIME     NULL,
    [Total Mins]        INT          NULL,
    [Total Call Mins]   INT          NULL,
    [Inbound Mins]      INT          NULL,
    [Outbound Mins]     INT          NULL,
    [Users Affected]    INT          NULL,
    [CC Users Affected] INT          NULL,
    [Total Users]       INT          NULL,
    [Total CC Users]    INT          NULL
);

