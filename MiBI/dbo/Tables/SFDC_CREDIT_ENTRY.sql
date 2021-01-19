CREATE TABLE [dbo].[SFDC_CREDIT_ENTRY] (
    [Created]         DATETIME      CONSTRAINT [DF_SFDC_CREDIT_ENTRY_Created] DEFAULT (getdate()) NULL,
    [Id]              VARCHAR (25)  NOT NULL,
    [CaseId]          VARCHAR (25)  NULL,
    [TransactionType] VARCHAR (100) NULL,
    [SubTotal]        FLOAT (53)    NULL,
    CONSTRAINT [PK_SFDC_CREDIT_ENTRY] PRIMARY KEY CLUSTERED ([Id] ASC)
);

