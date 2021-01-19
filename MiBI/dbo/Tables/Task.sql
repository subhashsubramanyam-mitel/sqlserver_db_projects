CREATE TABLE [dbo].[Task] (
    [ID]                    VARCHAR (50)  NOT NULL,
    [AssignedTo]            VARCHAR (500) NULL,
    [AssignedToID]          VARCHAR (500) NULL,
    [AttachmentURL]         VARCHAR (500) NULL,
    [Billable]              VARCHAR (50)  NULL,
    [BIllableMinutesWorked] VARCHAR (100) NULL,
    [Comments]              VARCHAR (MAX) NULL,
    [CreatedBy]             VARCHAR (500) NULL,
    [CreatedByID]           VARCHAR (500) NULL,
    [CreatedDate]           DATETIME      NULL,
    [DueDate]               DATETIME      NULL,
    [LastModifiedBy]        VARCHAR (500) NULL,
    [LastModifiedByID]      VARCHAR (500) NULL,
    [LastModifiedDate]      DATETIME      NULL,
    [Name]                  VARCHAR (500) NULL,
    [PartnerName]           VARCHAR (500) NULL,
    [Priority]              VARCHAR (500) NULL,
    [PublicField]           VARCHAR (50)  NULL,
    [RelatedToID]           VARCHAR (500) NULL,
    [Reminder]              VARCHAR (50)  NULL,
    [SKYLegacyID]           VARCHAR (50)  NULL,
    [Status]                VARCHAR (100) NULL,
    [Subject]               VARCHAR (MAX) NULL,
    [TaskRecordTypeID]      VARCHAR (500) NULL,
    [Type]                  VARCHAR (500) NULL,
    CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Task] TO [TacEngRole]
    AS [dbo];

