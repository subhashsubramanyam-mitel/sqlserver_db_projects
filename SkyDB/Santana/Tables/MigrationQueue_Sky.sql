CREATE TABLE [Santana].[MigrationQueue_Sky] (
    [Created]   DATETIME     CONSTRAINT [DF_Santana.MigrationQueue_Sky_Created] DEFAULT (getdate()) NULL,
    [AccountId] INT          NOT NULL,
    [OppId]     VARCHAR (50) NULL,
    [Status]    NCHAR (1)    CONSTRAINT [DF_MigrationQueue_Sky_Status] DEFAULT (N'N') NULL,
    [Error]     TEXT         NULL,
    [BatchNum]  VARCHAR (15) NULL,
    [OwnerId]   VARCHAR (25) NULL,
    [BatchHist] VARCHAR (50) NULL,
    CONSTRAINT [PK_Santana.MigrationQueue_Sky] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);


GO
GRANT INSERT
    ON OBJECT::[Santana].[MigrationQueue_Sky] TO [app_megasilo]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[Santana].[MigrationQueue_Sky] TO [app_megasilo]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[Santana].[MigrationQueue_Sky] TO [app_megasilo]
    AS [dbo];

