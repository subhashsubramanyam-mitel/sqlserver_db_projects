CREATE TABLE [dbo].[SkyPartner] (
    [Created]          DATETIME       CONSTRAINT [DF_SkyPartner_Created] DEFAULT (getdate()) NOT NULL,
    [LastModified]     DATETIME       NULL,
    [AccountPartnerId] NVARCHAR (255) NOT NULL,
    [AccountId]        NVARCHAR (255) NULL,
    [SfdcLastModified] DATETIME       NULL,
    [isPrimary]        NVARCHAR (255) NULL,
    [ReversePartnerId] NVARCHAR (255) NULL,
    [Role]             NVARCHAR (255) NULL,
    CONSTRAINT [PK_SkyPartner] PRIMARY KEY CLUSTERED ([AccountPartnerId] ASC)
);

