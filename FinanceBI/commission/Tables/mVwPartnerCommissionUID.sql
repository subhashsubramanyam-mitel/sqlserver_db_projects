CREATE TABLE [commission].[mVwPartnerCommissionUID] (
    [UID]                  NVARCHAR (24)   NOT NULL,
    [CommissionType]       VARCHAR (17)    NOT NULL,
    [PortalRegion]         NVARCHAR (50)   NOT NULL,
    [invoiceMonth]         DATE            NULL,
    [DatePeriodStart]      DATE            NULL,
    [DatePeriodEnd]        DATE            NULL,
    [SubAgentId]           NVARCHAR (128)  NULL,
    [SubAgent]             NVARCHAR (512)  NULL,
    [RepName]              NVARCHAR (256)  NULL,
    [PartnerID]            BIGINT          NULL,
    [Partner]              NVARCHAR (255)  NULL,
    [Customer]             NVARCHAR (100)  NULL,
    [Product]              NVARCHAR (512)  NULL,
    [Notes]                NVARCHAR (1024) NULL,
    [PortalLocationId]     INT             NULL,
    [PortalAccountId]      BIGINT          NULL,
    [Address]              NVARCHAR (100)  NULL,
    [City]                 NVARCHAR (100)  NULL,
    [ZipCode]              NVARCHAR (20)   NULL,
    [PartnerCurrencyCode]  VARCHAR (3)     NULL,
    [NetBilled_PC]         MONEY           NULL,
    [SalesComp_PC]         MONEY           NULL,
    [NetBilled]            MONEY           NULL,
    [SalesComp]            MONEY           NULL,
    [SalesCompRate]        NUMERIC (19, 4) NULL,
    [Region]               NVARCHAR (255)  COLLATE Latin1_General_BIN NULL,
    [Subregion]            NVARCHAR (255)  COLLATE Latin1_General_BIN NULL,
    [LichenLocationId]     INT             NULL,
    [ClienLichenAccountId] INT             NULL,
    [PaymentPlan]          NVARCHAR (255)  NULL
);


GO
CREATE CLUSTERED INDEX [IX-InvoiceMonth-PartnerID]
    ON [commission].[mVwPartnerCommissionUID]([invoiceMonth] ASC, [PartnerID] ASC);

