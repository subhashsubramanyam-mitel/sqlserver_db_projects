CREATE TABLE [dbo].[SFDC_OPP_AUDIT] (
    [Created]       DATETIME        CONSTRAINT [DF_SFDC_OPP_AUDIT_Created] DEFAULT (getdate()) NULL,
    [OpportunityId] VARCHAR (50)    COLLATE Latin1_General_BIN NOT NULL,
    [Amount]        NUMERIC (18, 2) NULL,
    [CloseDate]     DATE            NULL,
    [Stage]         VARCHAR (500)   COLLATE Latin1_General_BIN NULL
);

