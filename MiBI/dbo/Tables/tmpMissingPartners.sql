CREATE TABLE [dbo].[tmpMissingPartners] (
    [SfdcId]      NVARCHAR (255) NOT NULL,
    [LeadPartner] NVARCHAR (255) NULL,
    CONSTRAINT [PK_tmpMissingPartners] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);

