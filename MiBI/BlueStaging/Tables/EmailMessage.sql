CREATE TABLE [BlueStaging].[EmailMessage] (
    [Id]                  VARCHAR (20)    NOT NULL,
    [ParentId]            VARCHAR (20)    NULL,
    [ActivityId]          VARCHAR (20)    NULL,
    [FromName]            VARCHAR (1000)  NULL,
    [HasAttachment]       BIT             NULL,
    [Incoming]            BIT             NULL,
    [IsExternallyVisible] BIT             NULL,
    [IsDeleted]           BIT             NULL,
    [CreatedById]         VARCHAR (20)    NULL,
    [CreatedDate]         DATETIME        NULL,
    [LastModifiedById]    VARCHAR (20)    NULL,
    [LastModifiedDate]    DATETIME        NULL,
    [MessageDate]         DATETIME        NULL,
    [RelatedToId]         VARCHAR (20)    NULL,
    [Status]              VARCHAR (40)    NULL,
    [Subject]             NVARCHAR (3000) NULL,
    [FromAddress]         VARCHAR (1000)  NULL,
    [ToAddress]           VARCHAR (4000)  NULL,
    [CcAddress]           VARCHAR (4000)  NULL,
    CONSTRAINT [PK_blue_EmailMessage] PRIMARY KEY CLUSTERED ([Id] ASC)
);

