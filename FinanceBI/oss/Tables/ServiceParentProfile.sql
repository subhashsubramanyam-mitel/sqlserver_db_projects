CREATE TABLE [oss].[ServiceParentProfile] (
    [ServiceId]                 INT            NOT NULL,
    [ServiceName]               NVARCHAR (128) NOT NULL,
    [ServiceProvisioningBaseId] INT            NULL,
    [ProfileType]               NVARCHAR (20)  NULL,
    [ParentProfile]             VARCHAR (255)  NULL,
    [DateCreated]               DATETIME       NOT NULL,
    [DateModified]              DATETIME       NOT NULL,
    [ModifiedBy]                NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_oss_ServiceParentProfile] PRIMARY KEY CLUSTERED ([ServiceId] ASC)
);

