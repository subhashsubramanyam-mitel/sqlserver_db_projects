CREATE TABLE [sfdc].[Partner] (
    [Created]          DATETIME       CONSTRAINT [DF_Partner_Created] DEFAULT (getdate()) NOT NULL,
    [LastModified]     DATETIME       NULL,
    [AccountPartnerId] NVARCHAR (255) NOT NULL,
    [AccountId]        NVARCHAR (255) NULL,
    [SfdcLastModified] DATETIME       NULL,
    [IsPrimary]        NVARCHAR (255) NULL,
    [ReversePartnerId] NVARCHAR (255) NULL,
    [Role]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED ([AccountPartnerId] ASC)
);

