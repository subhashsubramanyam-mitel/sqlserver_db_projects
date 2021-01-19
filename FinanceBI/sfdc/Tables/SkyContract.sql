CREATE TABLE [sfdc].[SkyContract] (
    [Created]            DATETIME      NULL,
    [LastModified]       DATETIME      NULL,
    [ContractId]         VARCHAR (50)  NOT NULL,
    [AccountName]        VARCHAR (MAX) NULL,
    [ContractTerm]       DECIMAL (18)  NULL,
    [ContractStartDate]  DATETIME      NULL,
    [ContractEndDate]    DATETIME      NULL,
    [RemainingMonths]    DECIMAL (18)  NULL,
    [ContractType]       VARCHAR (500) NULL,
    [M5dbAccountId]      VARCHAR (50)  NULL,
    [StatusCategory]     VARCHAR (500) NULL,
    [Status]             VARCHAR (50)  NULL,
    [ContractRecordType] VARCHAR (500) NULL,
    [AccountId]          VARCHAR (50)  NULL,
    [SfdcCreateDate]     DATETIME      NULL,
    [SfdcModifiedDate]   DATETIME      NULL,
    CONSTRAINT [PK_SkyContract] PRIMARY KEY CLUSTERED ([ContractId] ASC)
);

