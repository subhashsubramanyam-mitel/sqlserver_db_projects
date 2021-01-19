CREATE TABLE [dbo].[ECC_AGENT_ERROR] (
    [Created]   DATETIME      CONSTRAINT [DF_ECC_AGENT_ERROR_Created] DEFAULT (getdate()) NULL,
    [RecordId]  VARCHAR (50)  NULL,
    [AgentName] VARCHAR (100) NULL,
    [Error]     TEXT          NULL
);

