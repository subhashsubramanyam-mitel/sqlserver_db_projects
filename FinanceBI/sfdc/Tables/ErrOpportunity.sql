CREATE TABLE [sfdc].[ErrOpportunity] (
    [Created]             DATETIME       NOT NULL,
    [LastModified]        DATETIME       NULL,
    [OpportunityID]       NVARCHAR (255) NOT NULL,
    [NumOfProfiles]       NVARCHAR (255) NULL,
    [AccountID]           NVARCHAR (255) NULL,
    [Amount]              MONEY          NULL,
    [Amount_Won]          MONEY          NULL,
    [Close_Date]          DATE           NULL,
    [Contract_Type]       NVARCHAR (255) NULL,
    [Deal_Size2]          NVARCHAR (255) NULL,
    [SfdcLastModified]    DATETIME       NULL,
    [LeadSource]          NVARCHAR (255) NULL,
    [OpportunityType]     NVARCHAR (255) NULL,
    [OriginalLeadSource]  NVARCHAR (255) NULL,
    [ReferredbyPartnerID] NVARCHAR (255) NULL,
    [Stage]               NVARCHAR (255) NULL,
    [StageCurrent]        NVARCHAR (255) NULL,
    [Won]                 NVARCHAR (255) NULL
);

