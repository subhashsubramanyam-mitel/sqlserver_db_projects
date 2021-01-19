CREATE TABLE [BlueStaging].[Account] (
    [Id]                VARCHAR (20)  NOT NULL,
    [Name]              VARCHAR (255) NULL,
    [CreatedDate]       DATETIME      NULL,
    [CreatedById]       VARCHAR (20)  NULL,
    [Theatre__c]        VARCHAR (255) NULL,
    [Risk_Category__c]  VARCHAR (255) NULL,
    [CustomerType__c]   VARCHAR (255) NULL,
    [Platform__c]       VARCHAR (255) NULL,
    [Status__c]         VARCHAR (255) NULL,
    [Type]              VARCHAR (255) NULL,
    [Customer_Since__c] VARCHAR (255) NULL,
    [Email__c]          VARCHAR (80)  NULL,
    [End_Points__c]     VARCHAR (255) NULL,
    [RecordTypeId]      VARCHAR (20)  NULL,
    CONSTRAINT [PK_blue_Account] PRIMARY KEY CLUSTERED ([Id] ASC)
);

