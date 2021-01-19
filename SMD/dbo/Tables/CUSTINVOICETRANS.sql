CREATE TABLE [dbo].[CUSTINVOICETRANS] (
    [INVENTTRANSID]       NVARCHAR (20)    NOT NULL,
    [invoicedate]         DATETIME         NOT NULL,
    [INVOICEID]           NVARCHAR (20)    NOT NULL,
    [ITEMID]              NVARCHAR (40)    NOT NULL,
    [NAME]                NVARCHAR (1000)  NOT NULL,
    [QTY]                 NUMERIC (28, 12) NOT NULL,
    [SALESID]             NVARCHAR (20)    NOT NULL,
    [SEMLINENUM]          INT              NOT NULL,
    [SEMPOSTINGORDERTYPE] NVARCHAR (10)    NOT NULL,
    [RECID]               BIGINT           NOT NULL
);

