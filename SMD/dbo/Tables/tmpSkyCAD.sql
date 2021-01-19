CREATE TABLE [dbo].[tmpSkyCAD] (
    [Created]              DATETIME         NULL,
    [SalesOrder]           NVARCHAR (31)    NOT NULL,
    [OrderDate]            DATETIME         NOT NULL,
    [ComDate]              DATETIME         NULL,
    [CustomerSfdcId]       VARCHAR (50)     COLLATE Latin1_General_BIN NOT NULL,
    [PartnerOfRecordCloud] VARCHAR (25)     COLLATE Latin1_General_BIN NULL,
    [PONumber]             NVARCHAR (50)    NULL,
    [IgName]               VARCHAR (100)    NULL,
    [HostedBilling]        NUMERIC (38, 12) NULL,
    [CurrencyCode]         VARCHAR (5)      NULL,
    [Status]               VARCHAR (5)      NULL,
    [Error]                TEXT             NULL,
    [BossAccountId]        INT              NULL
);

