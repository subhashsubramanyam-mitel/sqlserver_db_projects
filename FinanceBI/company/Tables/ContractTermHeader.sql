CREATE TABLE [company].[ContractTermHeader] (
    [Id]                     INT           NOT NULL,
    [AccountId]              INT           NOT NULL,
    [InitialCreationDate]    DATE          NULL,
    [InstallTermUOM]         CHAR (1)      NULL,
    [InstallTermQuantity]    INT           NULL,
    [InstallEnforcementDate] DATE          NULL,
    [LastInvoiceDate]        DATE          NULL,
    [LastInvoiceMRR]         MONEY         NULL,
    [EarlyTerminationFee]    MONEY         NOT NULL,
    [DateCreated]            DATETIME2 (7) NOT NULL,
    [DateModified]           DATETIME2 (7) NOT NULL,
    [ModifiedBy]             NVARCHAR (50) NOT NULL
);

