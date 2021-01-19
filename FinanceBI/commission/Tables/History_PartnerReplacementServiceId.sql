CREATE TABLE [commission].[History_PartnerReplacementServiceId] (
    [PCMonth]                 DATE           NULL,
    [Region]                  NCHAR (6)      NULL,
    [Service ID]              BIGINT         NOT NULL,
    [Crediting Partner ID]    BIGINT         NULL,
    [Crediting Partner]       NVARCHAR (255) NULL,
    [Service Commission Rate] FLOAT (53)     NULL,
    [Include Usage?]          NVARCHAR (255) NULL,
    [SubAgentId]              NVARCHAR (128) NULL,
    [SubAgent]                NVARCHAR (512) NULL,
    [RepName]                 NVARCHAR (256) NULL,
    [Id]                      INT            NULL,
    [DateModified]            DATETIME2 (4)  NOT NULL,
    [DateCreated]             DATETIME2 (4)  NOT NULL,
    [ModifiedBy]              NVARCHAR (50)  NOT NULL
);

