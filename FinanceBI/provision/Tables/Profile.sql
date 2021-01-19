CREATE TABLE [provision].[Profile] (
    [Id]            INT            NOT NULL,
    [LocationId]    INT            NOT NULL,
    [AccountId]     INT            NOT NULL,
    [ProfileTypeId] INT            NOT NULL,
    [TimeZoneId]    INT            CONSTRAINT [DF_Profile_TimeZoneId] DEFAULT ((490)) NULL,
    [Name]          NVARCHAR (100) NULL,
    [Tn]            NVARCHAR (15)  NULL,
    [TnCountryId]   INT            CONSTRAINT [DF_Profile_CountryId] DEFAULT ((840)) NOT NULL,
    [CallerId]      NVARCHAR (100) NULL,
    [IsActive]      BIT            CONSTRAINT [DF_Profile_IsActive] DEFAULT ((1)) NOT NULL,
    [IsDid]         BIT            CONSTRAINT [DF_Profile_IsDID] DEFAULT ((0)) NOT NULL,
    [IsConference]  BIT            CONSTRAINT [DF_Profile_IsConference] DEFAULT ((0)) NOT NULL,
    [IsMainLine]    BIT            CONSTRAINT [DF_Profile_IsMainLine] DEFAULT ((0)) NOT NULL,
    [Extension]     NVARCHAR (15)  NULL,
    CONSTRAINT [PK_DimProfile] PRIMARY KEY CLUSTERED ([Id] ASC)
);

