CREATE TABLE [MWSandbox].[MigrationMap] (
    [SkyProductId]         FLOAT (53)     NOT NULL,
    [SkyProductName]       NVARCHAR (255) NULL,
    [ConnectProductNoApps] FLOAT (53)     NULL,
    [ConnectProductApps]   FLOAT (53)     NULL,
    [MigrationOptionNotes] NVARCHAR (255) NULL,
    [Note]                 NVARCHAR (255) NULL,
    CONSTRAINT [PK_MigrationMap] PRIMARY KEY CLUSTERED ([SkyProductId] ASC)
);

