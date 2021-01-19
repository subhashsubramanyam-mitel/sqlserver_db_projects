CREATE TABLE [dbo].[Cases] (
    [ID]                                    VARCHAR (50)    NOT NULL,
    [CaseNumber]                            VARCHAR (255)   NOT NULL,
    [AccountID]                             VARCHAR (50)    NULL,
    [AccountSTID]                           VARCHAR (50)    NULL,
    [AccountName]                           VARCHAR (200)   NULL,
    [AccountNote]                           VARCHAR (500)   NULL,
    [AccountTeam]                           VARCHAR (50)    NULL,
    [ActiveAgreementCV]                     VARCHAR (500)   NULL,
    [ActiveServiceAgreement]                VARCHAR (500)   NULL,
    [AgentCoached]                          VARCHAR (500)   NULL,
    [Area]                                  VARCHAR (500)   NULL,
    [ATEscalatedBy]                         VARCHAR (500)   NULL,
    [ATEscalation]                          VARCHAR (500)   NULL,
    [AtRisk]                                VARCHAR (500)   NULL,
    [AtRiskIndicator]                       VARCHAR (500)   NULL,
    [AtRiskSituationID]                     VARCHAR (50)    NULL,
    [BetaParticipation]                     VARCHAR (500)   NULL,
    [Billable]                              VARCHAR (500)   NULL,
    [BillableReason]                        VARCHAR (500)   NULL,
    [Build]                                 VARCHAR (500)   NULL,
    [CaseOrigin]                            VARCHAR (500)   NULL,
    [CaseOwner]                             VARCHAR (500)   NULL,
    [CaseOwnerRole]                         VARCHAR (100)   NULL,
    [CaseReason]                            VARCHAR (500)   NULL,
    [ClosedDate]                            DATETIME        NULL,
    [CoachingCompletionDate]                DATETIME        NULL,
    [CommitDate]                            DATETIME        NULL,
    [CompletedQA]                           VARCHAR (500)   NULL,
    [ContactID]                             VARCHAR (500)   NULL,
    [ContactEmail]                          VARCHAR (500)   NULL,
    [ContactName]                           VARCHAR (500)   NULL,
    [ContactPhone]                          VARCHAR (500)   NULL,
    [CreatedBy]                             VARCHAR (500)   NULL,
    [CreatedByID]                           VARCHAR (50)    NULL,
    [CreatedDate]                           DATETIME        NULL,
    [CreditCard]                            VARCHAR (500)   NULL,
    [CreditTotal]                           VARCHAR (500)   NULL,
    [CriticalAccount]                       VARCHAR (500)   NULL,
    [CustomerType]                          VARCHAR (50)    NULL,
    [DaysToSLA]                             VARCHAR (500)   NULL,
    [Description]                           VARCHAR (MAX)   NULL,
    [DistributorOfRecord]                   VARCHAR (500)   NULL,
    [DynamicPortalLink]                     VARCHAR (500)   NULL,
    [EndUser]                               VARCHAR (500)   NULL,
    [EndUserID]                             VARCHAR (500)   NULL,
    [EngStatus]                             VARCHAR (500)   NULL,
    [Feature]                               VARCHAR (500)   NULL,
    [FraudPhoneNumber]                      VARCHAR (500)   NULL,
    [GeneratedFromUnreadEmail]              VARCHAR (500)   NULL,
    [Instance]                              VARCHAR (500)   NULL,
    [LastModifiedBy]                        VARCHAR (500)   NULL,
    [LastModifiedByID]                      VARCHAR (50)    NULL,
    [LastModifiedDate]                      DATETIME        NULL,
    [LastNPSSurvey]                         VARCHAR (500)   NULL,
    [LastSLAUpdateTACAgent]                 DATETIME        NULL,
    [LearningTip]                           VARCHAR (500)   NULL,
    [LegacyCaseID]                          VARCHAR (50)    NULL,
    [LegacyRallyID]                         VARCHAR (50)    NULL,
    [ManagerFollowing]                      VARCHAR (500)   NULL,
    [ManagerVisibility]                     VARCHAR (500)   NULL,
    [MasterCase]                            VARCHAR (50)    NULL,
    [MilestoneIcon]                         VARCHAR (500)   NULL,
    [MilestoneStatus]                       VARCHAR (500)   NULL,
    [NextMilestoneDueDate]                  DATETIME        NULL,
    [NPSScore]                              VARCHAR (500)   NULL,
    [NPSSurvey]                             VARCHAR (500)   NULL,
    [NPSSurveyNote]                         VARCHAR (500)   NULL,
    [OrderNumber]                           VARCHAR (500)   NULL,
    [ParentCase]                            VARCHAR (500)   NULL,
    [PartnerForCase]                        VARCHAR (500)   NULL,
    [PartnerNote]                           VARCHAR (500)   NULL,
    [PartnerOfRecord]                       VARCHAR (500)   NULL,
    [PartnerSTID]                           VARCHAR (50)    NULL,
    [Phase]                                 VARCHAR (500)   NULL,
    [PortalAccountDetails]                  VARCHAR (500)   NULL,
    [PortalReason]                          VARCHAR (500)   NULL,
    [Priority]                              VARCHAR (500)   NULL,
    [QAScore]                               VARCHAR (500)   NULL,
    [QuickCase]                             VARCHAR (500)   NULL,
    [Recipient]                             VARCHAR (500)   NULL,
    [RecordTypeID]                          VARCHAR (50)    NULL,
    [RecordTypeName]                        VARCHAR (50)    NULL,
    [RelatedIncident]                       VARCHAR (500)   NULL,
    [Resolution]                            VARCHAR (MAX)   NULL,
    [RFOAvailable]                          VARCHAR (500)   NULL,
    [RFORequested]                          VARCHAR (500)   NULL,
    [RootCause]                             VARCHAR (500)   NULL,
    [ScheduledDate]                         DATETIME        NULL,
    [SendAlert]                             VARCHAR (500)   NULL,
    [ServiceAgreementForCase]               VARCHAR (500)   NULL,
    [ServiceAgreementProcessEndTime]        VARCHAR (500)   NULL,
    [ServiceAgreementProcessStartTime]      VARCHAR (500)   NULL,
    [SkyLegacyID]                           VARCHAR (50)    NULL,
    [SLAFlag]                               VARCHAR (500)   NULL,
    [smx_case_no_of_days]                   VARCHAR (500)   NULL,
    [SO]                                    VARCHAR (500)   NULL,
    [Status]                                VARCHAR (500)   NULL,
    [SubFeature]                            VARCHAR (500)   NULL,
    [SubReason]                             VARCHAR (500)   NULL,
    [SubStatus]                             VARCHAR (500)   NULL,
    [Subject]                               VARCHAR (MAX)   NULL,
    [SupportOption]                         VARCHAR (500)   NULL,
    [TACu]                                  VARCHAR (500)   NULL,
    [TAM]                                   VARCHAR (500)   NULL,
    [TipCategory]                           VARCHAR (500)   NULL,
    [TipReason]                             VARCHAR (MAX)   NULL,
    [TrunkProvider]                         VARCHAR (500)   NULL,
    [Version]                               VARCHAR (500)   NULL,
    [EscalationSummary]                     VARCHAR (MAX)   NULL,
    [ValidEscalation]                       VARCHAR (10)    NULL,
    [Escalated]                             VARCHAR (10)    NULL,
    [ReasonEscalated]                       VARCHAR (500)   NULL,
    [DateEscalated]                         DATETIME        NULL,
    [ATEscalatedDate]                       DATETIME        NULL,
    [EscalateToSystems]                     VARCHAR (10)    NULL,
    [EscalateToNetworks]                    VARCHAR (10)    NULL,
    [DateOfFirstNOCEscalation]              DATETIME        NULL,
    [SupportEscalationDate]                 DATETIME        NULL,
    [EscalationDay]                         NUMERIC (18)    NULL,
    [EscalationMonth]                       NUMERIC (18)    NULL,
    [AgeSinceEscalation]                    NUMERIC (18)    NULL,
    [MrrDelta]                              NUMERIC (18, 2) NULL,
    [CreditApprovalStatus]                  VARCHAR (50)    NULL,
    [Region]                                VARCHAR (50)    NULL,
    [Theater]                               VARCHAR (100)   NULL,
    [OrgCaseOwnerRole]                      VARCHAR (100)   NULL,
    [xdeleted]                              VARCHAR (15)    NULL,
    [LegacyOpenDate]                        DATETIME        NULL,
    [LegacyCloseDate]                       DATETIME        NULL,
    [OwnerId]                               VARCHAR (25)    NULL,
    [CustomerPlatform]                      VARCHAR (50)    NULL,
    [Free_varchar15]                        VARCHAR (15)    NULL,
    [BusArchReason]                         VARCHAR (150)   NULL,
    [BusArchSubReason]                      VARCHAR (150)   NULL,
    [OpportunityId]                         VARCHAR (25)    NULL,
    [MCCSSPTag]                             VARCHAR (150)   NULL,
    [DelayReason]                           VARCHAR (150)   NULL,
    [RequestType]                           VARCHAR (100)   NULL,
    [RequestSubType]                        VARCHAR (100)   NULL,
    [BusArchCaseOwnerId]                    VARCHAR (25)    NULL,
    [BusArchCaseOwner]                      VARCHAR (150)   NULL,
    [MCSS1stReminderDate]                   DATETIME        NULL,
    [MCSS2ndReminderDate]                   DATETIME        NULL,
    [MCSSContactSurveySentLessThan7day]     INT             NULL,
    [MCSSSurveyExpirationDate]              DATETIME        NULL,
    [MCSSSurveySent]                        DATETIME        NULL,
    [MCSSSurveyStatus]                      VARCHAR (50)    NULL,
    [ReOpened]                              VARCHAR (10)    NULL,
    [ReOpenCounter]                         FLOAT (53)      CONSTRAINT [DF_Cases_ReOpenCounter] DEFAULT ((0)) NULL,
    [DateReopened]                          DATETIME        NULL,
    [TotalMRTs]                             FLOAT (53)      NULL,
    [Eligibility]                           VARCHAR (50)    NULL,
    [OpportunityNumber]                     VARCHAR (10)    NULL,
    [FCR]                                   AS              (case when datediff(hour,[CreatedDate],[ClosedDate])<(24) AND ([Status]='Closed - Known Issue' OR [Status]='Closed') then (1) when datediff(hour,[CreatedDate],[ClosedDate])>(24) AND ([Status]='Closed - Known Issue' OR [Status]='Closed') then (0)  end),
    [RelatedLoctionId]                      VARCHAR (15)    NULL,
    [_Open]                                 VARCHAR (15)    NULL,
    [CaseContactVARECertified__c]           VARCHAR (5)     NULL,
    [EndUserMiCloudConnectBusinessModel__c] VARCHAR (100)   NULL,
    [_open5]                                VARCHAR (5)     NULL,
    [Churn_Reason_Primary__c]               VARCHAR (100)   NULL,
    [Churn_Reason_Secondary__c]             VARCHAR (200)   NULL,
    [Related_Product__c]                    VARCHAR (100)   NULL,
    CONSTRAINT [PK_Cases] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_Cases_AccountTeam]
    ON [dbo].[Cases]([AccountTeam] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_Cases_AccountID]
    ON [dbo].[Cases]([AccountID] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_Cases_ClosedDate]
    ON [dbo].[Cases]([ClosedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_Cases_CreatedDate]
    ON [dbo].[Cases]([CreatedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_Cases_AccountName]
    ON [dbo].[Cases]([AccountName] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UNCIX_Cases_CaseNumber]
    ON [dbo].[Cases]([CaseNumber] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Cases] TO [TacEngRole]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Cases] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Cases] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Cases] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Cases] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Cases] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Cases] TO [Reporting]
    AS [dbo];

