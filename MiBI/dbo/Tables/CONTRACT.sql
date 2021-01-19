CREATE TABLE [dbo].[CONTRACT] (
    [Created]            DATETIME        CONSTRAINT [DF_CONTRACT_Created] DEFAULT (getdate()) NOT NULL,
    [SfdcCreatedDate]    DATETIME        NULL,
    [SfdcLastUpdateDate] DATETIME        NULL,
    [ContractId]         VARCHAR (50)    NOT NULL,
    [ContractName]       VARCHAR (500)   NULL,
    [ContractNumber]     VARCHAR (50)    NULL,
    [AccountId]          VARCHAR (50)    NULL,
    [AccountSTID]        VARCHAR (50)    NULL,
    [Type]               VARCHAR (50)    NULL,
    [IsCurrent]          VARCHAR (50)    NULL,
    [Status]             VARCHAR (50)    NULL,
    [AccountName]        VARCHAR (MAX)   NULL,
    [ContractTerm]       DECIMAL (18)    NULL,
    [ContractStartDate]  DATETIME        NULL,
    [ContractEndDate]    DATETIME        NULL,
    [RemainingMonths]    DECIMAL (18)    NULL,
    [ContractType]       VARCHAR (500)   NULL,
    [M5dbAccountID]      VARCHAR (50)    NULL,
    [StatusCategory]     VARCHAR (500)   NULL,
    [ContractRecordType] VARCHAR (500)   NULL,
    [LastModified]       DATETIME        NULL,
    [SkyLegacyID]        VARCHAR (50)    NULL,
    [ContractMRR]        DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_CONTRACT] PRIMARY KEY CLUSTERED ([ContractId] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[CONTRACT] TO [Reporting]
    AS [dbo];

