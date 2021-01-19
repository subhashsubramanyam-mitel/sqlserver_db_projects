CREATE TABLE [commission].[History_UsageInclusion] (
    [PCMonth]           DATE           NULL,
    [ChargeDescription] NVARCHAR (255) NOT NULL,
    [Include?]          NVARCHAR (255) NULL,
    [DateModified]      DATETIME2 (4)  NOT NULL,
    [DateCreated]       DATETIME2 (4)  NOT NULL,
    [ModifiedBy]        NVARCHAR (50)  NOT NULL,
    [Id]                INT            NULL
);

