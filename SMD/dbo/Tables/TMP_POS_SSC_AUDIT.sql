CREATE TABLE [dbo].[TMP_POS_SSC_AUDIT] (
    [ReportDate]  DATETIME        NOT NULL,
    [InvoiceDate] DATETIME        NULL,
    [PartnerId]   VARCHAR (50)    NULL,
    [Billings]    DECIMAL (38, 2) NULL
);

