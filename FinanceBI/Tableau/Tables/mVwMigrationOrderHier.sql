CREATE TABLE [Tableau].[mVwMigrationOrderHier] (
    [OrderId]                       INT            NOT NULL,
    [PMName]                        NVARCHAR (201) NOT NULL,
    [OrderType]                     NVARCHAR (50)  NOT NULL,
    [MasterOrderType]               VARCHAR (9)    NOT NULL,
    [MigrationOrderId]              INT            NOT NULL,
    [MigrationOrderStatus]          NVARCHAR (20)  NULL,
    [MigrationOrderDeprovisionDate] DATETIME2 (7)  NULL
);

