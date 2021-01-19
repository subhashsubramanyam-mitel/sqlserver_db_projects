CREATE TABLE [Tableau].[mVwContractLookup] (
    [ContractNumber]        VARCHAR (128)  NULL,
    [StartDate]             DATE           NULL,
    [DateCreated]           DATETIME2 (7)  NOT NULL,
    [ContractType]          NVARCHAR (100) NOT NULL,
    [Contracts]             INT            NULL,
    [ContractProfileAmount] INT            NULL,
    [ContractId]            VARCHAR (16)   NULL,
    [AccountId]             INT            NULL,
    [CommitmentDate]        DATE           NULL,
    [BusinessTermVersion]   NUMERIC (9, 2) NULL,
    [rn]                    BIGINT         NULL
);

