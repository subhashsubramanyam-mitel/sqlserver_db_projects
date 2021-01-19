CREATE TABLE [sfdc].[SFDC_OPP_History] (
    [Created]              DATETIME        CONSTRAINT [DF_SFDC_OPP_HIST_Created] DEFAULT (getdate()) NULL,
    [OpportunityId]        VARCHAR (50)    NOT NULL,
    [Name]                 VARCHAR (500)   NOT NULL,
    [Amount]               NUMERIC (18, 2) NULL,
    [CloseDate]            DATE            NULL,
    [Stage]                VARCHAR (500)   NULL,
    [DateLastModified]     DATETIME        NULL,
    [SfdcDateLastModified] DATETIME        NULL,
    [LastModifiedById]     VARCHAR (50)    NULL,
    [Current_Flag]         VARCHAR (10)    NULL
);

