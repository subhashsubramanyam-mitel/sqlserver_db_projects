CREATE TABLE [company].[ContractTermDetail] (
    [Id]                      INT            NOT NULL,
    [AccountContractHeaderId] INT            NOT NULL,
    [SalesForceContractId]    NVARCHAR (50)  NULL,
    [ContractTypeId]          INT            NOT NULL,
    [TermMonths]              INT            NOT NULL,
    [StartDate]               DATE           NULL,
    [EndDate]                 DATE           NULL,
    [ProfileAmount]           INT            NOT NULL,
    [DownturnPercentage]      INT            NOT NULL,
    [ProfileLimit]            INT            NULL,
    [MRR]                     MONEY          NOT NULL,
    [RenewAutomatically]      BIT            NOT NULL,
    [BusinessTermVersion]     NUMERIC (9, 2) NOT NULL,
    [SalesContractId]         INT            NULL,
    [IsActive]                BIT            NOT NULL,
    [DateCreated]             DATETIME2 (7)  NOT NULL,
    [DateModified]            DATETIME2 (7)  NOT NULL,
    [ModifiedBy]              NVARCHAR (50)  NOT NULL,
    [IsDeleted]               BIT            NULL
);

