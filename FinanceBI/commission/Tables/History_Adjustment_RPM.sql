CREATE TABLE [commission].[History_Adjustment_RPM] (
    [Id]                   INT             NOT NULL,
    [PC Month]             DATE            NULL,
    [Supplier]             NVARCHAR (255)  NULL,
    [Crediting Partner]    NVARCHAR (255)  NULL,
    [Crediting Partner ID] BIGINT          NULL,
    [Net Billed]           MONEY           NULL,
    [Gross Comm]           MONEY           NULL,
    [Sales Comm]           MONEY           NULL,
    [Type]                 NVARCHAR (255)  NULL,
    [Notes for Staff]      NVARCHAR (1024) NULL,
    [Notes]                NVARCHAR (1024) NULL,
    [SubAgent]             NVARCHAR (512)  NULL,
    [DateModified]         DATETIME2 (4)   NOT NULL,
    [DateCreated]          DATETIME2 (4)   NOT NULL,
    [ModifiedBy]           NVARCHAR (50)   NOT NULL,
    [RepId]                NVARCHAR (128)  NULL,
    [RepName]              NVARCHAR (256)  NULL,
    [GlobalID]             INT             NULL
);

