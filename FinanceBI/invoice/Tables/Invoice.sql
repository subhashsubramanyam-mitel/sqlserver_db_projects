CREATE TABLE [invoice].[Invoice] (
    [Id]                    INT  NOT NULL,
    [DateGenerated]         DATE NOT NULL,
    [AccountId]             INT  NOT NULL,
    [InvoiceGroupId]        INT  NOT NULL,
    [DatePeriodStart_Local] DATE NOT NULL,
    [DatePeriodEnd_Local]   DATE NOT NULL,
    [LichenInvoiceId]       INT  NULL,
    [CurrencyId]            INT  CONSTRAINT [DF_Invoice_CurrencyId] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_FactInvoice] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_Dategenerated]
    ON [invoice].[Invoice]([DateGenerated] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-InvoiceGroup]
    ON [invoice].[Invoice]([InvoiceGroupId] ASC);

