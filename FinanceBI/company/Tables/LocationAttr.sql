CREATE TABLE [company].[LocationAttr] (
    [LocationId]           INT            NOT NULL,
    [Subtenant]            NVARCHAR (100) NULL,
    [InitialMRR]           MONEY          NULL,
    [ActiveMRR]            MONEY          NULL,
    [NumProfiles]          INT            NULL,
    [IsOnNet]              INT            NULL,
    [CountForecastChanges] INT            NULL,
    [IsClientMPLS]         INT            CONSTRAINT [DF_LocationAttr_IsClientMPLS] DEFAULT ((0)) NULL,
    [NumPendingProfiles]   INT            CONSTRAINT [DF_LocationAttr_NumPendingProfiles] DEFAULT ((0)) NULL,
    [ConnectivityType]     NVARCHAR (50)  NULL,
    CONSTRAINT [PK_LocationAttr] PRIMARY KEY CLUSTERED ([LocationId] ASC)
);

