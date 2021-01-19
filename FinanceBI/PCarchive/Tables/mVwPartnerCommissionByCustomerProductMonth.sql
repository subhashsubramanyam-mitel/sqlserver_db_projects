CREATE TABLE [PCarchive].[mVwPartnerCommissionByCustomerProductMonth] (
    [CommissionType] NVARCHAR (32)   NOT NULL,
    [invoiceMonth]   DATETIME2 (7)   NULL,
    [PartnerID]      BIGINT          NULL,
    [Partner]        NVARCHAR (255)  NULL,
    [Customer]       NVARCHAR (100)  NULL,
    [Product]        NVARCHAR (512)  NULL,
    [NetBilled]      FLOAT (53)      NULL,
    [SalesComp]      FLOAT (53)      NULL,
    [Notes]          NVARCHAR (1024) NULL
);

