CREATE TABLE [sales].[ContractLineItem] (
    [Id]               INT             NOT NULL,
    [ContractId]       INT             NOT NULL,
    [ProductId]        INT             NOT NULL,
    [LocationId]       INT             NOT NULL,
    [MRR]              DECIMAL (10, 2) NOT NULL,
    [NRR]              DECIMAL (10, 2) NOT NULL,
    [TrialDuration]    INT             NOT NULL,
    [ContractQuantity] INT             NOT NULL,
    [Quantity]         INT             NOT NULL,
    [DateCreated]      DATETIME2 (4)   NOT NULL,
    [DateModified]     DATETIME2 (4)   NOT NULL,
    [ModifiedBy]       NVARCHAR (50)   NOT NULL,
    [WaiveNRR]         BIT             CONSTRAINT [DF__ContractL__Waive__564F588E] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_sales_ContractLineItem] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [IX_sales_ContractLineItem_ContractLocProd] UNIQUE NONCLUSTERED ([ContractId] ASC, [LocationId] ASC, [ProductId] ASC)
);

