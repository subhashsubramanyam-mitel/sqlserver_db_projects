CREATE TABLE [commission].[History_PartnerTable] (
    [PCMonth]     DATE           NULL,
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [PartnerID]   INT            NOT NULL,
    [PartnerName] NVARCHAR (255) NULL,
    [PaymentPlan] NVARCHAR (255) NULL
);

