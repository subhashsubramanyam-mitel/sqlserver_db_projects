CREATE TABLE [enum].[ServiceStatus] (
    [Id]        INT            NOT NULL,
    [Name]      NVARCHAR (128) NOT NULL,
    [GroupName] NVARCHAR (128) NULL,
    CONSTRAINT [PK_ServiceStatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);

