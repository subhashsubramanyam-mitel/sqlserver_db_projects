CREATE TABLE [commission].[mVwPartnerCommissionCompact] (
    [InvoiceMonth]         DATE            NULL,
    [PartnerId]            BIGINT          NULL,
    [Partner]              NVARCHAR (255)  NULL,
    [CommissionType]       VARCHAR (17)    NOT NULL,
    [Customer]             NVARCHAR (100)  NULL,
    [Product]              NVARCHAR (512)  NULL,
    [DatePeriodStart]      DATE            NULL,
    [DatePeriodEnd]        DATE            NULL,
    [SubAgentId]           NVARCHAR (128)  NULL,
    [SubAgent]             NVARCHAR (512)  NULL,
    [RepName]              NVARCHAR (256)  NULL,
    [Notes]                NVARCHAR (1024) NULL,
    [PortalRegion]         NVARCHAR (50)   NULL,
    [PortalLocationId]     INT             NULL,
    [PortalAccountId]      INT             NULL,
    [Address]              NVARCHAR (100)  NULL,
    [City]                 NVARCHAR (100)  NULL,
    [ZipCode]              NVARCHAR (20)   NULL,
    [SalesCompRate]        NUMERIC (19, 4) NULL,
    [LichenLocationId]     INT             NULL,
    [ClienLichenAccountId] INT             NULL,
    [Quantity]             INT             NULL,
    [PartnerCurrencyCode]  VARCHAR (3)     NULL,
    [NetBilled_PC]         MONEY           NULL,
    [SalesComp_PC]         MONEY           NULL,
    [NetBilled]            MONEY           NULL,
    [SalesComp]            MONEY           NULL,
    [CommissionMonth]      DATE            NULL,
    [PaymentPlan]          NVARCHAR (255)  NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20190524-171725]
    ON [commission].[mVwPartnerCommissionCompact]([InvoiceMonth] ASC, [PartnerId] ASC);

