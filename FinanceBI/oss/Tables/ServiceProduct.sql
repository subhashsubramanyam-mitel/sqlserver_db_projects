CREATE TABLE [oss].[ServiceProduct] (
    [ServiceId]              INT            NOT NULL,
    [ProductId]              INT            NULL,
    [ServiceClassId]         INT            NOT NULL,
    [ServiceStatusId]        INT            NOT NULL,
    [AccountId]              INT            NOT NULL,
    [LocationId]             INT            NULL,
    [ServiceBundleId]        INT            NULL,
    [Name]                   NVARCHAR (128) NULL,
    [IsAttachedToTN]         BIT            NOT NULL,
    [TN]                     NVARCHAR (15)  NULL,
    [InvoiceLabel]           NVARCHAR (128) NULL,
    [OrderTypeId]            INT            NULL,
    [WasInInitialOrder]      BIT            NOT NULL,
    [MonthlyCharge]          MONEY          NULL,
    [OneTimeCharge]          MONEY          NULL,
    [DateSvcCreated]         DATE           NULL,
    [DateSvcModified]        DATE           NULL,
    [DateSvcLiveScheduled]   DATE           NULL,
    [DateSvcLiveActual]      DATE           NULL,
    [DateSvcClosed]          DATE           NULL,
    [DateBillingValidFrom]   DATE           NULL,
    [DateBillingValidTo]     DATE           NULL,
    [MonthSetupInvoiced]     DATE           NULL,
    [MonthMRRFirstInvoiced]  DATE           NULL,
    [MonthMRRLastInvoiced]   DATE           NULL,
    [DateMRRInvoicedTo]      DATE           NULL,
    [MonthCreditIssued]      DATE           NULL,
    [DateCreditedFrom]       DATE           NULL,
    [DateCreditedTo]         DATE           NULL,
    [CreatedByPersonId]      INT            NULL,
    [ModifiedByPersonId]     INT            NULL,
    [DataIssueId]            INT            CONSTRAINT [DF_ServiceProduct_DataIssueId] DEFAULT ((0)) NOT NULL,
    [LichenServiceId]        INT            NULL,
    [LichenPlanId]           INT            NULL,
    [OrderProjectManagerId]  INT            NULL,
    [OrderCreatedByPersonId] INT            NULL,
    [MonthLastInvoiced]      DATE           NULL,
    [InvoiceServiceGroupId]  INT            NULL,
    [DateSvcCloseOrdered]    DATE           NULL,
    [MonthSvcCloseOrdered]   DATE           NULL,
    [ClosedByPersonId]       INT            NULL,
    [OrderId]                INT            NULL,
    [WTN]                    NVARCHAR (128) NULL,
    [CircuitStatusId]        INT            NULL,
    [OrderedById]            INT            NULL,
    [OrderSalesPersonId]     INT            NULL,
    [InFirstContract]        BIT            CONSTRAINT [DF_ServiceProduct_InFirstContract] DEFAULT ((0)) NULL,
    [DateSvcVoided]          DATE           NULL,
    [DateSvcSetToActive]     DATE           NULL,
    [SvcClusterId]           INT            NULL,
    [CurrencyId]             INT            NULL,
    [MasterOrderTypeId]      INT            NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_SvcProd]
    ON [oss].[ServiceProduct]([ServiceId] ASC, [ProductId] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170511-081652]
    ON [oss].[ServiceProduct]([TN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_AccountId_LoctionId]
    ON [oss].[ServiceProduct]([AccountId] ASC, [LocationId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_OrderID]
    ON [oss].[ServiceProduct]([OrderId] ASC);

