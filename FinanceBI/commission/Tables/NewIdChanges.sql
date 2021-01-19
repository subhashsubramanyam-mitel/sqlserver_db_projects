CREATE TABLE [commission].[NewIdChanges] (
    [PartnerName]    NVARCHAR (255) NOT NULL,
    [CurrentID]      INT            NOT NULL,
    [NewID]          INT            NOT NULL,
    [NewPartnerName] NVARCHAR (255) NOT NULL,
    [Notes]          NVARCHAR (255) NULL,
    [ChangedDate]    DATETIME       DEFAULT (getdate()) NOT NULL
);

