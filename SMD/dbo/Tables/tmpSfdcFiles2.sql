CREATE TABLE [dbo].[tmpSfdcFiles2] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [Title]                  NVARCHAR (255) NULL,
    [Description]            NVARCHAR (MAX) NULL,
    [VersionData]            NVARCHAR (255) NULL,
    [PathOnClient]           NVARCHAR (255) NULL,
    [ContentURL]             NVARCHAR (255) NULL,
    [OwnerId]                NVARCHAR (255) NULL,
    [FirstPublishLocationId] NVARCHAR (255) NULL,
    [RecordTypeId]           NVARCHAR (255) NULL,
    [Content_Type__c]        NVARCHAR (255) NULL,
    [Product__c]             NVARCHAR (255) NULL,
    [Country__c]             NVARCHAR (255) NULL,
    [Duration_of_video__c]   NVARCHAR (255) NULL,
    [Thumbnail_URL__c]       NVARCHAR (255) NULL,
    [Page_Name__c]           NVARCHAR (255) NULL,
    [Category__c]            NVARCHAR (255) NULL,
    [Sub_Category__c]        NVARCHAR (255) NULL,
    [Language__c]            NVARCHAR (255) NULL,
    [Error]                  TEXT           NULL,
    CONSTRAINT [PK_tmpSfdcFiles2] PRIMARY KEY CLUSTERED ([Id] ASC)
);

