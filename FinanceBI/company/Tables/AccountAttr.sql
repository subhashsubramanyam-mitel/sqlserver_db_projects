CREATE TABLE [company].[AccountAttr] (
    [AccountId]             INT           NOT NULL,
    [AccountStatus]         NVARCHAR (32) NOT NULL,
    [DateFirstInvoiced]     DATE          NULL,
    [DateFirstServiceLive]  DATE          NULL,
    [ActiveMRR]             MONEY         NULL,
    [NumLocationsWithSeats] INT           NULL,
    [NumLocationsTotal]     INT           NULL,
    [AccountTeam]           NVARCHAR (32) NULL,
    [NumLocationsActive]    INT           NULL,
    [NumLocationsPending]   INT           NULL,
    [NumProfiles]           INT           NULL,
    [IsBillable]            INT           CONSTRAINT [DF_AccountAttr_IsBillable] DEFAULT ((1)) NOT NULL,
    [IsUsfChargeable]       INT           CONSTRAINT [DF_AccountAttr_IsUsfChargeable] DEFAULT ((1)) NOT NULL,
    [CreditHoldType]        VARCHAR (10)  NULL,
    [NumPendingProfiles]    INT           CONSTRAINT [DF_AccountAttr_NumPendingProfiles] DEFAULT ((0)) NOT NULL,
    [DateLastInvoiced]      DATE          NULL,
    [AccountManagerId]      INT           NULL,
    [PrimaryHandset]        NVARCHAR (32) NULL,
    [NumCisco]              INT           NULL,
    [NumIP4nn]              INT           NULL,
    [InternalAccountTypeId] INT           NULL,
    [PartnerTypeId]         INT           NULL,
    [AccountGuid]           VARCHAR (50)  NULL,
    [IsQualifiedForAob]     BIT           NULL,
    [IsMCSSEnabled]         BIT           NULL,
    [IsCompliant]           BIT           NULL,
    CONSTRAINT [PK_AccountAttr] PRIMARY KEY CLUSTERED ([AccountId] ASC),
    CONSTRAINT [FK_AccountAttr_Date_FirstInvoiced] FOREIGN KEY ([DateFirstInvoiced]) REFERENCES [enum].[DimDate] ([Date]),
    CONSTRAINT [FK_AccountAttr_Date_FirstServiceLive] FOREIGN KEY ([DateFirstServiceLive]) REFERENCES [enum].[DimDate] ([Date])
);


GO
ALTER TABLE [company].[AccountAttr] NOCHECK CONSTRAINT [FK_AccountAttr_Date_FirstInvoiced];


GO
ALTER TABLE [company].[AccountAttr] NOCHECK CONSTRAINT [FK_AccountAttr_Date_FirstServiceLive];

