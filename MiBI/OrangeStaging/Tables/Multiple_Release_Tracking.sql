﻿CREATE TABLE [OrangeStaging].[Multiple_Release_Tracking] (
    [Defect__r Name]                         VARCHAR (300)  NULL,
    [Defect__r Abstract__c]                  VARCHAR (500)  NULL,
    [Defect__r Priority__c]                  VARCHAR (100)  NULL,
    [Defect__r Severity__c]                  VARCHAR (100)  NULL,
    [Defect__r Keywords__c]                  VARCHAR (500)  NULL,
    [Defect__r Defect_Status__c]             VARCHAR (100)  NULL,
    [Defect__r Found__r Name]                VARCHAR (300)  NULL,
    [Defect__r Area__c]                      VARCHAR (100)  NULL,
    [Defect__r Sub_Area__c]                  VARCHAR (100)  NULL,
    [Defect__r Parent_Project__c]            VARCHAR (200)  NULL,
    [Defect__r Developer__r Name]            VARCHAR (300)  NULL,
    [Defect__r Build__r Name]                VARCHAR (200)  NULL,
    [Defect__r QA_Owner__r Name]             VARCHAR (200)  NULL,
    [Defect__r Field_Issues__c]              VARCHAR (100)  NULL,
    [Defect__r Found_via__c]                 VARCHAR (100)  NULL,
    [Defect__r CreatedDate]                  VARCHAR (100)  NULL,
    [Defect__r Estimated_Resolution_Date__c] VARCHAR (50)   NULL,
    [Defect__r Blocker__c]                   VARCHAR (100)  NULL,
    [Defect__r Blocked__c]                   VARCHAR (50)   NULL,
    [Defect__r Blocked_Reason__c]            VARCHAR (1000) NULL,
    [Defect__r Number_of_Cases__c]           VARCHAR (50)   NULL,
    [Defect__r Type__c]                      VARCHAR (100)  NULL,
    [Defect__r Eng_Group__c]                 VARCHAR (100)  NULL,
    [Defect__r User_StoryID__c]              VARCHAR (100)  NULL,
    [Defect__r Feature__c]                   VARCHAR (100)  NULL,
    [Defect__r LastModifiedDate]             VARCHAR (50)   NULL,
    [Defect__r Beta_Blocker__c]              VARCHAR (50)   NULL,
    [Defect__r Reason__c]                    VARCHAR (1000) NULL,
    [Defect__r Reviewed__c]                  VARCHAR (50)   NULL,
    [Defect__r Deployment_Type__c]           VARCHAR (50)   NULL,
    [Defect__r Cluster_Information__c]       VARCHAR (50)   NULL,
    [Name]                                   VARCHAR (500)  NULL,
    [Status__c]                              VARCHAR (4000) NULL,
    [Sub_Status__c]                          VARCHAR (4000) NULL,
    [ClosedDate__c]                          VARCHAR (50)   NULL,
    [Rejected_Date__c]                       VARCHAR (50)   NULL,
    [Rejected_Reason__c]                     VARCHAR (4000) NULL,
    [Resolve_Date__c]                        VARCHAR (50)   NULL,
    [CreatedDate]                            VARCHAR (50)   NULL,
    [Verified_Date__c]                       VARCHAR (50)   NULL,
    [CreatedBy Full_Name__c]                 VARCHAR (100)  NULL,
    [Change_List__c]                         VARCHAR (500)  NULL,
    [LastModifiedDate]                       VARCHAR (50)   NULL,
    [Corrected_in__r Name]                   VARCHAR (100)  NULL,
    [PatchedIn__c]                           VARCHAR (4000) NULL
);
