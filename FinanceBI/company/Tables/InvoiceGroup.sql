CREATE TABLE [company].[InvoiceGroup] (
    [Id]                   INT           NOT NULL,
    [AccountId]            INT           NOT NULL,
    [Balance]              MONEY         NULL,
    [DateBalanceSet_Local] DATE          NULL,
    [IsActive]             BIT           NOT NULL,
    [NeedPaperInvoice]     BIT           NOT NULL,
    [PayByCreditCard]      BIT           NOT NULL,
    [Name]                 NCHAR (128)   NULL,
    [LichenInvoiceGroupId] INT           CONSTRAINT [DF_InvoiceGroup_LichenInvoiceGroupId] DEFAULT ((-1)) NULL,
    [BillingContactId]     INT           NULL,
    [AxAccountNum]         NVARCHAR (40) NULL,
    [CurrencyId]           INT           CONSTRAINT [DF_InvoiceGroup_CurrencyId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_INVOICEGROUP] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_InvoiceGroup_Account] FOREIGN KEY ([AccountId]) REFERENCES [company].[Account] ([Id]) NOT FOR REPLICATION,
    CONSTRAINT [FK_InvoiceGroup_Date] FOREIGN KEY ([DateBalanceSet_Local]) REFERENCES [enum].[DimDate] ([Date])
);


GO
ALTER TABLE [company].[InvoiceGroup] NOCHECK CONSTRAINT [FK_InvoiceGroup_Account];


GO
ALTER TABLE [company].[InvoiceGroup] NOCHECK CONSTRAINT [FK_InvoiceGroup_Date];

