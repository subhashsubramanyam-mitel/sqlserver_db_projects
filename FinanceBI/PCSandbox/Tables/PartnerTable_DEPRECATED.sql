CREATE TABLE [PCSandbox].[PartnerTable_DEPRECATED] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [PartnerID]   INT            NOT NULL,
    [PartnerName] NVARCHAR (255) NULL,
    [PaymentPlan] NVARCHAR (255) NULL,
    CONSTRAINT [PK_PartnerTable] PRIMARY KEY CLUSTERED ([Id] ASC)
);

