CREATE TABLE [MWSandbox].[InterestedAccounts] (
    [AccountId]  INT          NULL,
    [Name]       VARCHAR (57) NOT NULL,
    [Interested] VARCHAR (5)  CONSTRAINT [DF_InterestedAccounts_Interested] DEFAULT ('YES') NOT NULL
);

