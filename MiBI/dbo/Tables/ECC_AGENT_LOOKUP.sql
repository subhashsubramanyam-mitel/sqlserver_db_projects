﻿CREATE TABLE [dbo].[ECC_AGENT_LOOKUP] (
    [Created]   DATETIME      CONSTRAINT [DF_ECC_AGENT_LOOKUP_Created] DEFAULT (getdate()) NOT NULL,
    [AgentID]   FLOAT (53)    NOT NULL,
    [UserEmail] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_ECC_AGENT_LOOKUP] PRIMARY KEY CLUSTERED ([AgentID] ASC)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[ECC_AGENT_LOOKUP] TO [TACECC]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ECC_AGENT_LOOKUP] TO [TACECC]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ECC_AGENT_LOOKUP] TO [TACECC]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ECC_AGENT_LOOKUP] TO [TACECC]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[ECC_AGENT_LOOKUP] TO [TACECC]
    AS [dbo];

