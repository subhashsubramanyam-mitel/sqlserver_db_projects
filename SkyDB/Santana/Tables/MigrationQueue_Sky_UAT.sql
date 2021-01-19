CREATE TABLE [Santana].[MigrationQueue_Sky_UAT] (
    [Created]   DATETIME     NULL,
    [AccountId] INT          NOT NULL,
    [OppId]     VARCHAR (50) NULL,
    [Status]    NCHAR (1)    CONSTRAINT [DF_MigrationQueue_Sky_UAT_Status] DEFAULT (N'N') NULL,
    [Error]     TEXT         NULL,
    [BatchNum]  VARCHAR (15) NULL,
    [OwnerId]   VARCHAR (25) NULL,
    [BatchHist] VARCHAR (50) NULL,
    CONSTRAINT [PK_MigrationQueue_Sky_UAT] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);


GO
GRANT ALTER
    ON OBJECT::[Santana].[MigrationQueue_Sky_UAT] TO [app_megasilo]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[Santana].[MigrationQueue_Sky_UAT] TO [app_megasilo]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[Santana].[MigrationQueue_Sky_UAT] TO [app_megasilo]
    AS [dbo];

