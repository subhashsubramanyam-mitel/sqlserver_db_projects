CREATE TABLE [dbo].[SFDC_RENEWAL_TRK] (
    [Created]    DATETIME       CONSTRAINT [DF_SFDC_RENEWAL_TRK_Created] DEFAULT (getdate()) NOT NULL,
    [SalesOrder] NVARCHAR (20)  NOT NULL,
    [CustomerId] NVARCHAR (40)  NOT NULL,
    [PO]         NVARCHAR (100) NOT NULL,
    [StartDate]  DATETIME       NOT NULL,
    [ExpireDate] DATETIME       NOT NULL,
    [Type]       NVARCHAR (100) NULL,
    [ItemId]     NVARCHAR (50)  NULL,
    [SKU]        NCHAR (10)     NULL,
    [Status]     NCHAR (2)      CONSTRAINT [DF_SFDC_RENEWAL_TRK_Status] DEFAULT ('N') NULL,
    [Error]      TEXT           NULL,
    CONSTRAINT [PK_SFDC_RENEWAL_TRK] PRIMARY KEY CLUSTERED ([SalesOrder] ASC)
);

