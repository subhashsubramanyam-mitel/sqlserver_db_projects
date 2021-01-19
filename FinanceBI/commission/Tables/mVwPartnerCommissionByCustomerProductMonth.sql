CREATE TABLE [commission].[mVwPartnerCommissionByCustomerProductMonth] (
    [InvoiceMonth]        DATE           NULL,
    [PartnerId]           BIGINT         NULL,
    [Partner]             NVARCHAR (255) NULL,
    [CommissionType]      VARCHAR (17)   NOT NULL,
    [Customer]            NVARCHAR (100) NULL,
    [Product]             NVARCHAR (512) NULL,
    [PartnerCurrencyCode] VARCHAR (3)    NULL,
    [NetBilled_PC]        MONEY          NULL,
    [SalesComp_PC]        MONEY          NULL,
    [NetBilled]           MONEY          NULL,
    [SalesComp]           MONEY          NULL,
    [Notes]               INT            NULL
);

