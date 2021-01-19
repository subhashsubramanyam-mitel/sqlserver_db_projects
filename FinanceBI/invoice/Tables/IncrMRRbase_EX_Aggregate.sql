CREATE TABLE [invoice].[IncrMRRbase_EX_Aggregate] (
    [AccountId]    INT             NOT NULL,
    [InvoiceMonth] DATETIME        NOT NULL,
    [ActiveMRR]    NUMERIC (38, 4) NULL,
    [Num]          INT             NULL,
    CONSTRAINT [PK_IncrMRRbase_EX_Aggregate] PRIMARY KEY CLUSTERED ([AccountId] ASC, [InvoiceMonth] ASC)
);

