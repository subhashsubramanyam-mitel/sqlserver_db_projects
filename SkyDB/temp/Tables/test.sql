CREATE TABLE [temp].[test] (
    [Id]                    INT            NOT NULL,
    [Name]                  NVARCHAR (100) NOT NULL,
    [Number]                NVARCHAR (50)  NOT NULL,
    [CompanyTypeId]         INT            NOT NULL,
    [CompanySalesChannelId] INT            NOT NULL,
    [AccountCategoryId]     INT            NOT NULL,
    [AccountSubCategoryId]  INT            NOT NULL,
    [PrimaryClusterId]      INT            NULL,
    [OutDialDigit]          CHAR (1)       NOT NULL,
    [IsActive]              BIT            NOT NULL,
    [ParentAccountId]       INT            NULL,
    [LichenAccountId]       INT            NULL,
    [PartnerId]             INT            NULL,
    [IsHybrid]              BIT            NOT NULL,
    [DeployEnvId]           INT            NULL,
    [NativeOid]             INT            NULL
);

