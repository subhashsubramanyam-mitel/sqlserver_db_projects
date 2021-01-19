CREATE TABLE [dbo].[MigrationCustList1130] (
    [LichenAccountId]   INT            NULL,
    [AccountId]         FLOAT (53)     NULL,
    [AccountName]       NVARCHAR (255) NULL,
    [ActiveMRR]         MONEY          NULL,
    [ContractType]      NVARCHAR (100) NULL,
    [DaysSinceStart]    INT            NULL,
    [StartDate]         DATE           NULL,
    [DaysUtilEnd]       INT            NULL,
    [EndDate]           DATE           NULL,
    [AtRisk_SFDC]       VARCHAR (3)    NULL,
    [Sites]             INT            NULL,
    [NumProfiles]       INT            NULL,
    [HasNonStandardExt] VARCHAR (3)    NOT NULL,
    [ExtStartsWith0Or9] INT            NOT NULL,
    [HasSCC]            VARCHAR (3)    NOT NULL,
    [CRM]               NVARCHAR (255) NULL,
    [InterestedAccount] VARCHAR (5)    NOT NULL,
    [OutDialDigit]      CHAR (1)       NULL,
    [BatchNumber]       VARCHAR (3)    NOT NULL
);

