CREATE TABLE [dbo].[OPPORTUNITY] (
    [Created]                       DATETIME        CONSTRAINT [DF_OPPORTUNITY_Created] DEFAULT (getdate()) NOT NULL,
    [OpportunityID]                 VARCHAR (50)    NOT NULL,
    [AccountID]                     VARCHAR (50)    NULL,
    [AccountName]                   VARCHAR (500)   NULL,
    [AccountPartnerReferredID]      VARCHAR (50)    NULL,
    [Age]                           VARCHAR (500)   NULL,
    [AmountWon]                     DECIMAL (18, 2) NULL,
    [CloseDate]                     DATETIME        NULL,
    [ContractType]                  VARCHAR (500)   NULL,
    [DealMasterAgent]               VARCHAR (500)   NULL,
    [DealSize]                      VARCHAR (500)   NULL,
    [EstimatedMRR]                  DECIMAL (18, 2) NULL,
    [EstimatedNRR]                  DECIMAL (18, 2) NULL,
    [ExpectedMRRRevenue]            DECIMAL (18, 2) NULL,
    [ExpectedNRRRevenue]            DECIMAL (18, 2) NULL,
    [InferWonAmount]                DECIMAL (18, 2) NULL,
    [isSecondary]                   VARCHAR (500)   NULL,
    [LastModified]                  DATETIME        NULL,
    [LeadSource]                    VARCHAR (500)   NULL,
    [LeadPartner]                   VARCHAR (100)   NULL,
    [MRRAmount]                     DECIMAL (18, 2) NULL,
    [Name]                          VARCHAR (500)   NULL,
    [NextStep]                      VARCHAR (500)   NULL,
    [NRRAmount]                     DECIMAL (18, 2) NULL,
    [NumOfProfiles]                 VARCHAR (500)   NULL,
    [OriginalLeadSource]            VARCHAR (500)   NULL,
    [OwnerID]                       VARCHAR (50)    NULL,
    [OwnerRole]                     VARCHAR (500)   NULL,
    [PartnerRep]                    VARCHAR (500)   NULL,
    [Probability]                   VARCHAR (500)   NULL,
    [RecordType]                    VARCHAR (100)   NULL,
    [ReferredbyPartnerID]           VARCHAR (50)    NULL,
    [ReferringPartner]              VARCHAR (500)   NULL,
    [ReferringPartnerSTID]          VARCHAR (50)    NULL,
    [SfdcCreateDateUTC]             DATETIME        NULL,
    [SfdcLastUpdateDateUTC]         DATETIME        NULL,
    [ShoreTelID]                    VARCHAR (50)    NULL,
    [SkyLegacyID]                   VARCHAR (50)    NULL,
    [Stage]                         VARCHAR (500)   NULL,
    [StageCurrent]                  VARCHAR (500)   NULL,
    [TPFMRR]                        DECIMAL (18, 2) NULL,
    [Type]                          VARCHAR (100)   NULL,
    [Won]                           VARCHAR (500)   NULL,
    [OpportunityNumber]             VARCHAR (100)   NULL,
    [CampaignDept]                  VARCHAR (100)   NULL,
    [LeadCategory]                  VARCHAR (500)   NULL,
    [NumOfConnectBundles]           VARCHAR (500)   NULL,
    [SubType]                       VARCHAR (500)   NULL,
    [CountryCode]                   VARCHAR (50)    NULL,
    [ShoreTelTerritory]             VARCHAR (50)    NULL,
    [CurrencyIsoCode]               VARCHAR (50)    NULL,
    [LastModifiedById]              VARCHAR (50)    NULL,
    [ProductInterest]               VARCHAR (500)   NULL,
    [PartnerSelectedCampaign]       VARCHAR (500)   NULL,
    [OpportunityRegion]             VARCHAR (500)   NULL,
    [OpportunitySubRegion]          VARCHAR (500)   NULL,
    [Qualified]                     VARCHAR (50)    NULL,
    [Proposal]                      VARCHAR (50)    NULL,
    [QualificationDate]             DATETIME        NULL,
    [NumofTelephoneUsers]           VARCHAR (50)    NULL,
    [OpportunityTheater]            VARCHAR (500)   NULL,
    [ImplementationTimelineScoring] FLOAT (53)      CONSTRAINT [DF_OPPORTUNITY_ImplementationTimelineScoring] DEFAULT ((0)) NULL,
    [IsClosed]                      VARCHAR (50)    NULL,
    [HeritageId]                    VARCHAR (25)    NULL,
    [PrimaryOppId]                  VARCHAR (25)    NULL,
    [TotalContractValue]            FLOAT (53)      NULL,
    [AccountTerritoryId]            VARCHAR (50)    NULL,
    [DealId]                        VARCHAR (255)   NULL,
    [ReasonLost]                    VARCHAR (50)    NULL,
    [CreatedByRole]                 VARCHAR (255)   NULL,
    [ForecastCategory]              VARCHAR (50)    NULL,
    [AdvancedISRId]                 VARCHAR (25)    NULL,
    [TotalSeats]                    FLOAT (53)      NULL,
    [OpportunitySource]             VARCHAR (50)    NULL,
    [PrimaryCampaignName]           VARCHAR (500)   NULL,
    [NumberOfEndPointsSeats]        FLOAT (53)      NULL,
    [CreatedById]                   VARCHAR (25)    NULL,
    [SubAgentId]                    VARCHAR (25)    NULL,
    [SubAgentName_Text]             VARCHAR (255)   NULL,
    [Term]                          FLOAT (53)      NULL,
    [Product_Specifics__c]          VARCHAR (255)   NULL,
    [OpportunityQuantity]           FLOAT (53)      NULL,
    [ReferringCustomerAccount]      VARCHAR (255)   NULL,
    [DealSize_Orig]                 VARCHAR (50)    NULL,
    [DealType]                      VARCHAR (100)   NULL,
    [SelfStart]                     VARCHAR (250)   NULL,
    [ProposalPromotionApplied]      VARCHAR (255)   NULL,
    [FreeServicePromotion]          VARCHAR (250)   NULL,
    [DescriptionInternal]           TEXT            NULL,
    [CurrentVendors]                VARCHAR (250)   NULL,
    [OppLocations]                  FLOAT (53)      CONSTRAINT [DF_OPPORTUNITY_OppLocations] DEFAULT ((0)) NULL,
    [ConsolodatedReportPartner]     VARCHAR (250)   NULL,
    [WelcomeContact]                VARCHAR (150)   NULL,
    [NCAM]                          VARCHAR (150)   NULL,
    [AgentCAM]                      VARCHAR (150)   NULL,
    [CommTAM]                       VARCHAR (150)   NULL,
    [DebookedOppId]                 VARCHAR (25)    NULL,
    [TypeOfOpportunity]             VARCHAR (100)   NULL,
    [Contract_Signed_By__c]         VARCHAR (150)   NULL,
    [Eligible_Support_Partner__c]   VARCHAR (100)   NULL,
    [OneView_Subtype__c]            VARCHAR (100)   NULL,
    [VE__c]                         VARCHAR (5)     NULL,
    CONSTRAINT [PK_OPPORTUNITY] PRIMARY KEY CLUSTERED ([OpportunityID] ASC)
);


GO
create TRIGGER [dbo].[AuditOpty]
ON dbo.OPPORTUNITY
FOR  DELETE
AS 
SET NOCOUNT ON
BEGIN 
		--Log delete
		INSERT INTO OPP_AUDIT ( OptyId, UserName)
		
		select OpportunityID,   SUSER_SNAME()  
				From deleted
 
END

GO
GRANT SELECT
    ON OBJECT::[dbo].[OPPORTUNITY] TO [TacEngRole]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Populated via Batch From Opp Location table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OPPORTUNITY', @level2type = N'COLUMN', @level2name = N'OppLocations';

