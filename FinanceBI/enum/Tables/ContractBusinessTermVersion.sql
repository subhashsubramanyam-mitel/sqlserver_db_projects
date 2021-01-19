CREATE TABLE [enum].[ContractBusinessTermVersion] (
    [Id]                                INT           NOT NULL,
    [Name]                              NVARCHAR (30) NOT NULL,
    [MinDownturnPct]                    INT           NOT NULL,
    [MaxDownturnPct]                    INT           NOT NULL,
    [ServiceCommitmentDateMaxAddMonths] INT           NULL,
    [IsAutoProvisioned]                 BIT           NOT NULL,
    CONSTRAINT [PK_ContractBusinessTermVersion] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 90)
);

