CREATE TABLE [BlueStaging].[CaseComment] (
    [Id]                     VARCHAR (20) NOT NULL,
    [ParentId]               VARCHAR (20) NULL,
    [CreatedById]            VARCHAR (20) NULL,
    [CreatedDate]            DATETIME     NULL,
    [IsDeleted]              BIT          NULL,
    [IsPublished]            BIT          NULL,
    [IsNotificationSelected] BIT          NULL,
    [LastModifiedById]       VARCHAR (20) NULL,
    [LastModifiedDate]       DATETIME     NULL,
    CONSTRAINT [PK_blue_CaseComment] PRIMARY KEY CLUSTERED ([Id] ASC)
);

