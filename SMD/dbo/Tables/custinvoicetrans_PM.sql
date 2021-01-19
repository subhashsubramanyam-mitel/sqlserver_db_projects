CREATE TABLE [dbo].[custinvoicetrans_PM] (
    [salesid]       NVARCHAR (20)    NOT NULL,
    [invoiceId]     NVARCHAR (20)    NOT NULL,
    [lineAmountMst] NUMERIC (28, 12) NOT NULL,
    [qty]           NUMERIC (28, 12) NOT NULL,
    [inventtransid] NVARCHAR (20)    NOT NULL,
    [itemid]        NVARCHAR (40)    NOT NULL
);

