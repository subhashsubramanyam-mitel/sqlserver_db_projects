CREATE TABLE [ax].[InvoiceTrx] (
    [InvoiceId]      INT             NOT NULL,
    [Type]           VARCHAR (2)     NOT NULL,
    [CUSTNMBR]       CHAR (15)       NULL,
    [TRANSNUMB]      CHAR (21)       NOT NULL,
    [DOCTYPE]        VARCHAR (16)    NULL,
    [DOCAMNT]        NUMERIC (38, 5) NULL,
    [DOCDATE]        VARCHAR (10)    NULL,
    [RAWDOCDATE]     DATETIME        NULL,
    [DOCNUMBR]       CHAR (23)       NULL,
    [CURTRXAM]       NUMERIC (38, 5) NULL,
    [INVOICEGROUPID] CHAR (15)       NULL,
    [CURRENCYCODE]   NVARCHAR (3)    NULL,
    CONSTRAINT [PK_InvoiceTrx] PRIMARY KEY CLUSTERED ([InvoiceId] ASC, [Type] ASC, [TRANSNUMB] ASC)
);

