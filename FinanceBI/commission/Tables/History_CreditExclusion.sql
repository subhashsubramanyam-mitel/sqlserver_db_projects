CREATE TABLE [commission].[History_CreditExclusion] (
    [PCMonth]           DATE           NULL,
    [ChargeDescription] NVARCHAR (255) NOT NULL,
    [Exclude?]          NVARCHAR (255) NULL,
    [DateModified]      DATETIME2 (4)  NOT NULL,
    [DateCreated]       DATETIME2 (4)  NOT NULL,
    [ModifiedBy]        NVARCHAR (50)  NOT NULL,
    [Id]                INT            NULL
);

