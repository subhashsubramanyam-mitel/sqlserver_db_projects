CREATE TABLE [sfdc].[MatVwAccountMap_Base] (
    [SfdcId]          VARCHAR (18)   COLLATE Latin1_General_BIN NULL,
    [SfdcAccount]     VARCHAR (100)  COLLATE Latin1_General_BIN NOT NULL,
    [SfdcTerritoryId] VARCHAR (50)   COLLATE Latin1_General_BIN NULL,
    [M5dbAccountId]   INT            NULL,
    [Account]         NVARCHAR (100) NULL
);


GO
CREATE CLUSTERED INDEX [Clustered-M5DBAccountId]
    ON [sfdc].[MatVwAccountMap_Base]([M5dbAccountId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SfdcId]
    ON [sfdc].[MatVwAccountMap_Base]([SfdcId] ASC);

