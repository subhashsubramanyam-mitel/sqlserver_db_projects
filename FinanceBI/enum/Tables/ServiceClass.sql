CREATE TABLE [enum].[ServiceClass] (
    [Id]               INT            NOT NULL,
    [ParentId]         INT            NULL,
    [ServiceGroup]     NVARCHAR (50)  NOT NULL,
    [Name]             NVARCHAR (128) NOT NULL,
    [LichenClassName]  NVARCHAR (512) NULL,
    [RootName]         NVARCHAR (128) NOT NULL,
    [DisplaySortOrder] INT            NOT NULL,
    [nParentId]        INT            NULL,
    [nRootName]        NVARCHAR (128) NULL,
    [nServiceGroup]    NVARCHAR (50)  NULL,
    CONSTRAINT [PK_ServiceTypeId] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ServiceClass_ServiceClass] FOREIGN KEY ([ParentId]) REFERENCES [enum].[ServiceClass] ([Id])
);

