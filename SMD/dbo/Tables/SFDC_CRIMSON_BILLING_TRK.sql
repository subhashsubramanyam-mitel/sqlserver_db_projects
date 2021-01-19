CREATE TABLE [dbo].[SFDC_CRIMSON_BILLING_TRK] (
    [SalesOrder]  VARCHAR (61)    NOT NULL,
    [InvoiceDate] DATETIME2 (7)   NULL,
    [ComDate]     DATETIME2 (7)   NULL,
    [Customer]    NVARCHAR (255)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [AxCode]      NVARCHAR (255)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PartnerID]   NVARCHAR (255)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Total]       NUMERIC (38, 6) NULL,
    [Status]      CHAR (1)        CONSTRAINT [DF_SFDC_CRIMSON_BILLING_TRK_Status] DEFAULT ('N') NULL,
    [Error]       TEXT            NULL,
    CONSTRAINT [PK_SFDC_CRIMSON_BILLING_TRK] PRIMARY KEY CLUSTERED ([SalesOrder] ASC)
);

