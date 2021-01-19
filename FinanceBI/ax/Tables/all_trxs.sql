CREATE TABLE [ax].[all_trxs] (
    [CUSTNMBR]       CHAR (15)        NULL,
    [TRANSNUMB]      CHAR (21)        NULL,
    [DOCTYPE]        VARCHAR (16)     NULL,
    [DOCAMNT]        NUMERIC (28, 12) NOT NULL,
    [DOCDATE]        VARCHAR (10)     NULL,
    [RAWDOCDATE]     DATETIME2 (7)    NOT NULL,
    [DOCNUMBR]       CHAR (23)        NULL,
    [CURTRXAM]       NUMERIC (29, 12) NULL,
    [INVOICEGROUPID] INT              NULL
);

