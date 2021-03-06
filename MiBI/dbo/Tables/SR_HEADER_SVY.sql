﻿CREATE TABLE [dbo].[SR_HEADER_SVY] (
    [SfdcId]                 VARCHAR (50)  NULL,
    [SR_NUM]                 VARCHAR (254) NOT NULL,
    [SR_TITLE]               VARCHAR (MAX) NULL,
    [PartnerId]              VARCHAR (500) NULL,
    [Partner]                VARCHAR (500) NULL,
    [AccountId]              VARCHAR (500) NULL,
    [Account]                VARCHAR (500) NULL,
    [SR_AREA]                VARCHAR (500) NULL,
    [Res_Stat]               VARCHAR (MAX) NULL,
    [LOGIN]                  VARCHAR (500) NULL,
    [Date_Open]              DATETIME      NOT NULL,
    [ACT_CLOSE_DT]           DATETIME      NULL,
    [SR_Version]             VARCHAR (500) NULL,
    [Phase]                  VARCHAR (500) NULL,
    [Source]                 VARCHAR (500) NULL,
    [Feature]                VARCHAR (500) NULL,
    [Severity]               VARCHAR (500) NULL,
    [Priority]               VARCHAR (500) NULL,
    [Status]                 VARCHAR (500) NULL,
    [Sub_Status]             VARCHAR (500) NULL,
    [FST_NAME]               VARCHAR (500) NULL,
    [LAST_NAME]              VARCHAR (500) NULL,
    [EMAIL_ADDR]             VARCHAR (500) NULL,
    [ContactId]              VARCHAR (500) NULL,
    [Origin]                 VARCHAR (500) NULL,
    [Trunk_Provider__c]      VARCHAR (500) NULL,
    [CreatedBy]              VARCHAR (500) NULL,
    [ContactPhone]           VARCHAR (500) NULL,
    [LastModifiedDate]       DATETIME      NULL,
    [ActiveServiceAgreement] VARCHAR (100) NULL,
    [LegacySR_NUM]           VARCHAR (50)  NULL,
    [EndUser]                VARCHAR (500) NULL,
    [Resolution]             VARCHAR (MAX) NULL,
    [ContactSfdcId]          VARCHAR (50)  NULL,
    [JobTitle]               VARCHAR (500) NULL,
    [OwnerName]              VARCHAR (500) NULL,
    [ManagerVisibility]      VARCHAR (50)  NULL,
    [ManagerFollowing]       VARCHAR (500) NULL,
    [DaysToSLA]              VARCHAR (50)  NULL,
    [SrBuild]                VARCHAR (50)  NULL,
    [EngineeringStatus]      VARCHAR (50)  NULL,
    [OwnerRole]              VARCHAR (100) NULL,
    [Billable]               VARCHAR (10)  NULL,
    [BillableReason]         VARCHAR (50)  NULL,
    [SalesOrder]             VARCHAR (50)  NULL,
    [CreditCard]             VARCHAR (50)  NULL,
    [SLAFlag]                VARCHAR (100) NULL,
    [LastActivity]           DATETIME      NULL,
    [EndUserTheater]         VARCHAR (50)  NULL,
    [EndUserRegion]          VARCHAR (50)  NULL,
    [EndUserSubRegion]       VARCHAR (50)  NULL,
    [CommitTime]             DATETIME      NULL,
    [SubFeature]             VARCHAR (500) NULL,
    CONSTRAINT [PK_SR_HEADER_SVY3] PRIMARY KEY CLUSTERED ([SR_NUM] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SR_HEADER_SVY] TO [TacEngRole]
    AS [dbo];

