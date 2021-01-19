CREATE TABLE [people].[Person] (
    [Id]                 INT            NOT NULL,
    [LocationId]         INT            NULL,
    [AccountId]          INT            NULL,
    [IsPerson]           BIT            NOT NULL,
    [IsActive]           BIT            NOT NULL,
    [UserName]           NVARCHAR (100) NULL,
    [FirstName]          NVARCHAR (100) NOT NULL,
    [LastName]           NVARCHAR (100) NOT NULL,
    [ProfileTN]          NVARCHAR (15)  NULL,
    [PersonalPhone]      NVARCHAR (40)  NULL,
    [Email]              NVARCHAR (255) NULL,
    [IsDecisionMaker]    BIT            NOT NULL,
    [IsPhoneManager]     BIT            NOT NULL,
    [IsEmergencyContact] BIT            NOT NULL,
    [IsBillingContact]   BIT            NOT NULL,
    [IsTechnicalContact] BIT            NOT NULL,
    [IsPartner]          BIT            NOT NULL,
    [IsM5Staff]          BIT            NOT NULL,
    [LichenPersonId]     INT            NULL,
    [Department]         NVARCHAR (100) NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Person_ProfileTN]
    ON [people].[Person]([ProfileTN] ASC)
    INCLUDE([Id], [FirstName], [LastName], [IsDecisionMaker], [IsPhoneManager], [IsBillingContact], [IsTechnicalContact]);

