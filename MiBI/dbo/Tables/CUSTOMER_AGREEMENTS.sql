CREATE TABLE [dbo].[CUSTOMER_AGREEMENTS] (
    [Created]               DATETIME      CONSTRAINT [DF_CUSTOMER_AGREEMENTS2_Created] DEFAULT (getdate()) NULL,
    [SfdcCreateDateUTC]     DATETIME      NULL,
    [SfdcLastUpdateDateUTC] DATETIME      NULL,
    [SfdcId]                VARCHAR (20)  NOT NULL,
    [Agreement_Id]          VARCHAR (100) NULL,
    [Type]                  VARCHAR (50)  NULL,
    [StartDate]             DATETIME      NULL,
    [EndDate]               DATETIME      NULL,
    [Status]                VARCHAR (30)  NULL,
    [End_User_Csn]          VARCHAR (50)  NULL,
    [PoNumber]              VARCHAR (100) NULL,
    [Valid]                 VARCHAR (1)   NULL,
    [Notes]                 VARCHAR (MAX) NULL,
    [CustomerID]            VARCHAR (50)  NULL,
    [CustomerSTID]          VARCHAR (50)  NULL,
    [ProductName]           VARCHAR (200) NULL,
    [StatusCustom]          VARCHAR (30)  NULL,
    CONSTRAINT [PK_CUSTOMER_AGREEMENTS2] PRIMARY KEY CLUSTERED ([SfdcId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_AGREEMENTS] TO [TacEngRole]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CUSTOMER_AGREEMENTS] TO [PMData]
    AS [dbo];

