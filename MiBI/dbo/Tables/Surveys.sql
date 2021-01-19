CREATE TABLE [dbo].[Surveys] (
    [ID]                                          VARCHAR (50)  NOT NULL,
    [AccountID]                                   VARCHAR (50)  NULL,
    [CaseNumber]                                  VARCHAR (50)  NULL,
    [ContactID]                                   VARCHAR (50)  NULL,
    [CreatedDate]                                 DATETIME      CONSTRAINT [DF_Surveys_CreatedDate] DEFAULT (getdate()) NULL,
    [CustomerEffort]                              VARCHAR (255) NULL,
    [DataCollectionId]                            VARCHAR (50)  NULL,
    [DataCollectionName]                          VARCHAR (200) NULL,
    [FirstContactResolution]                      VARCHAR (255) NULL,
    [LastModifiedDate]                            DATETIME      NULL,
    [OrigAccountId]                               VARCHAR (50)  NULL,
    [OrigPartnerId]                               VARCHAR (50)  NULL,
    [PartnerComment]                              TEXT          NULL,
    [PartnerSTID]                                 VARCHAR (50)  NULL,
    [PartnerScore]                                INT           NULL,
    [PrimaryComment]                              TEXT          NULL,
    [PrimaryScore]                                INT           NULL,
    [Product]                                     VARCHAR (500) NULL,
    [ProductComent]                               TEXT          NULL,
    [RepEffectiveness]                            VARCHAR (255) NULL,
    [RepProfessionalism]                          VARCHAR (255) NULL,
    [RepResponsiveness]                           VARCHAR (255) NULL,
    [RepSpeedToRespond]                           VARCHAR (255) NULL,
    [RepTechKnowledge]                            VARCHAR (255) NULL,
    [ResponseReceivedDate]                        DATETIME      NULL,
    [Status]                                      VARCHAR (50)  NULL,
    [StatusDesc]                                  VARCHAR (500) NULL,
    [ContactName]                                 VARCHAR (500) NULL,
    [ContactEmail]                                VARCHAR (500) NULL,
    [Source]                                      VARCHAR (50)  CONSTRAINT [DF_Surveys_Source] DEFAULT ('Get Feedback') NULL,
    [Consulting_Satisfaction__c]                  INT           NULL,
    [Issues_Resolution_Satisfaction__c]           INT           NULL,
    [Kept_Informed_by_Project_Manager__c]         INT           NULL,
    [Knowing_Who_to_Contact__c]                   INT           NULL,
    [Project_Kickoff_Satisfaction__c]             INT           NULL,
    [Sales_Team_Help_Selecting_Right_Solution__c] INT           NULL,
    [Satisfaction_with_Professionalism__c]        INT           NULL,
    [Satisfaction_with_Resolution__c]             INT           NULL,
    [Satisfaction_with_Time_to_Answer__c]         INT           NULL,
    [Satisfaction_with_Time_to_Resolve__c]        INT           NULL,
    [Satisfaction_with_Troubleshooting__c]        INT           NULL,
    [System_Launch_Satisfaction__c]               INT           NULL,
    [Training_Satisfaction__c]                    INT           NULL,
    [Project_Owner__c]                            VARCHAR (150) NULL,
    [Improvement_Suggestion__c]                   TEXT          NULL,
    [Elements_Preventing_Launch_within_Timefr__c] VARCHAR (MAX) NULL,
    [Help_Requested_to_Resolve_Issue__c]          VARCHAR (255) NULL,
    [ProjectOwnerId]                              VARCHAR (25)  NULL,
    [GF_ContactMitel]                             VARCHAR (150) NULL,
    [GF_OnlineResources]                          VARCHAR (150) NULL,
    [GF_OutstandingIssue]                         VARCHAR (150) NULL,
    [EngagementModel]                             VARCHAR (50)  NULL,
    [ProjectId]                                   VARCHAR (25)  NULL,
    [SurveyName]                                  VARCHAR (50)  NULL,
    [Additional_Feedback__c]                      TEXT          NULL,
    [Capturing_Requirements__c]                   INT           NULL,
    [Circuit_Test_Activation__c]                  INT           NULL,
    [Clear_Expectations__c]                       INT           NULL,
    [Consulting_Network_Issues__c]                INT           NULL,
    [Delivering_Requirements__c]                  INT           NULL,
    [FirstReminderDate__c]                        DATETIME      NULL,
    [Improvements__c]                             TEXT          NULL,
    [Keeping_Informed__c]                         INT           NULL,
    [Live_Webinar__c]                             INT           NULL,
    [Network_Readiness__c]                        INT           NULL,
    [Opportunity__c]                              VARCHAR (25)  NULL,
    [Paid_Training__c]                            INT           NULL,
    [Partner__c]                                  VARCHAR (250) NULL,
    [PM_Manager_Email__c]                         VARCHAR (200) NULL,
    [PM_Manager_Mgr_Email__c]                     VARCHAR (200) NULL,
    [Project__c]                                  VARCHAR (25)  NULL,
    [Project_Kick_Off__c]                         INT           NULL,
    [Resolving_Roadblocks__c]                     INT           NULL,
    [Scheduling_Go_Live__c]                       INT           NULL,
    [SecondReminderDate__c]                       DATETIME      NULL,
    [Self_paced_training__c]                      INT           NULL,
    [Submitting_Port__c]                          INT           NULL,
    [Technical_Assistance__c]                     INT           NULL,
    [Testing__c]                                  INT           NULL,
    [Understanding_Business_Needs__c]             INT           NULL,
    [Updates_on_Port__c]                          INT           NULL,
    [RecordType]                                  VARCHAR (200) NULL,
    [Ability_to_Utilize_Features__c]              FLOAT (53)    NULL,
    [Continue_with_Mitel__c]                      FLOAT (53)    NULL,
    [Contributing_Factors__c]                     TEXT          NULL,
    [Functional_Role__c]                          VARCHAR (50)  NULL,
    [Likely_to_Purchase__c]                       VARCHAR (50)  NULL,
    [Purchasing_Role__c]                          VARCHAR (50)  NULL,
    [Referenceable__c]                            VARCHAR (50)  NULL,
    [Search_Alternate_Providers__c]               FLOAT (53)    NULL,
    [Solution_achieves_business_objectives__c]    FLOAT (53)    NULL,
    [What_Mitel_can_do_better__c]                 TEXT          NULL,
    [Implementation_Specialist__c]                VARCHAR (255) NULL,
    [System_Engineer__c]                          VARCHAR (255) NULL,
    [Network_Engineer__c]                         VARCHAR (255) NULL,
    CONSTRAINT [PK_Surveys] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Surveys_DataCollectionName]
    ON [dbo].[Surveys]([DataCollectionName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Surveys_CaseNumber]
    ON [dbo].[Surveys]([CaseNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Surveys_AccountID]
    ON [dbo].[Surveys]([AccountID] ASC);


GO
GRANT DELETE
    ON OBJECT::[dbo].[Surveys] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Surveys] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Surveys] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[Surveys] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\AMohandas]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\brobison]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\aneuman]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\alossing]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\MBrondum]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\dorr]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Surveys] TO [CANDY\beswanson]
    AS [dbo];

