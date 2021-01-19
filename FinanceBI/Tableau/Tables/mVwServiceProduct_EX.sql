CREATE TABLE [Tableau].[mVwServiceProduct_EX] (
    [ServiceId]               INT             NOT NULL,
    [ProductId]               INT             NULL,
    [LichenServiceId]         INT             NULL,
    [LichenPlanId]            INT             NULL,
    [ServiceClassId]          INT             NOT NULL,
    [ServiceStatusId]         INT             NOT NULL,
    [AccountId]               INT             NOT NULL,
    [InvoiceServiceGroupId]   INT             NULL,
    [LocationId]              INT             NULL,
    [ServiceBundleId]         INT             NULL,
    [Name]                    NVARCHAR (4000) NULL,
    [IsAttachedToTN]          BIT             NOT NULL,
    [TN]                      NVARCHAR (15)   NULL,
    [InvoiceLabel]            NVARCHAR (128)  NULL,
    [OrderId]                 INT             NULL,
    [OrderTypeId]             INT             NULL,
    [WasInInitialOrder]       BIT             NOT NULL,
    [OrderProjectManagerId]   INT             NULL,
    [OrderCreatedByPersonId]  INT             NULL,
    [OrderedById]             INT             NULL,
    [OrderSalesPersonId]      INT             NULL,
    [MonthlyCharge]           NUMERIC (38, 6) NULL,
    [OneTimeCharge]           NUMERIC (38, 6) NULL,
    [DateSvcCreated]          DATE            NULL,
    [DateSvcModified]         DATE            NULL,
    [DateSvcLiveScheduled]    DATE            NULL,
    [DateSvcLiveActual]       DATE            NULL,
    [DateSvcCloseOrdered]     DATE            NULL,
    [MonthSvcCloseOrdered]    DATE            NULL,
    [ClosedByPersonId]        INT             NULL,
    [DateSvcClosed]           DATE            NULL,
    [DateBillingValidFrom]    DATE            NULL,
    [DateBillingValidTo]      DATE            NULL,
    [IsBilledFirstTime]       INT             NOT NULL,
    [MonthSetupInvoiced]      DATE            NULL,
    [MonthLastInvoiced]       DATE            NULL,
    [MonthMRRFirstInvoiced]   DATE            NULL,
    [MonthMRRLastInvoiced]    DATE            NULL,
    [DateMRRInvoicedTo]       DATE            NULL,
    [MonthCreditIssued]       DATE            NULL,
    [DateCreditedFrom]        DATE            NULL,
    [DateCreditedTo]          DATE            NULL,
    [CreatedByPersonId]       INT             NULL,
    [ModifiedByPersonId]      INT             NULL,
    [BillingStage]            VARCHAR (17)    NULL,
    [DataIssueId]             INT             NOT NULL,
    [Loc Connecticitytype]    NVARCHAR (50)   NULL,
    [Loc InvoiceGroupId]      INT             NULL,
    [Ac FirstNps]             INT             NULL,
    [Ac LastNps]              INT             NULL,
    [Ac DateFirstServiceLive] DATE            NULL,
    [Ac DateFirstInvoiced]    DATE            NULL,
    [Ac PartnerId]            INT             NULL,
    [NumLifeDays]             INT             NULL,
    [LifeDaysSegmentId]       INT             NULL,
    [IsMRRZero]               VARCHAR (7)     NOT NULL,
    [IsNRCZero]               VARCHAR (7)     NOT NULL,
    [CircuitStatusId]         INT             NULL,
    [LifeDaysNewSegmentId]    INT             NULL,
    [InFirstContract]         BIT             NULL,
    [SvcCluster]              NCHAR (100)     NULL,
    [SvcPlatform]             NVARCHAR (20)   NULL,
    [DateSvcVoided]           DATE            NULL,
    [DateSvcSetToActive]      DATE            NULL,
    [CurrencyCode]            CHAR (3)        NOT NULL,
    [CurrencyId]              INT             NOT NULL,
    [MonthlyCharge_LC]        MONEY           NULL,
    [OneTimeCharge_LC]        MONEY           NULL,
    [DateLocLiveForecast]     DATE            NULL,
    [MasterOrderTypeId]       INT             NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_mVwServiceProduct_EX]
    ON [Tableau].[mVwServiceProduct_EX]([ServiceId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_mVwServiceProduct_EX_orderid]
    ON [Tableau].[mVwServiceProduct_EX]([OrderId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_mVwServiceProduct_EX_Statusid]
    ON [Tableau].[mVwServiceProduct_EX]([ServiceStatusId] ASC);

