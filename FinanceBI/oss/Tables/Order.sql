CREATE TABLE [oss].[Order] (
    [Id]                        INT             NOT NULL,
    [Name]                      NVARCHAR (128)  NULL,
    [OrderTypeId]               INT             NOT NULL,
    [OrderStatusId]             INT             NOT NULL,
    [AccountId]                 INT             NOT NULL,
    [LocationId]                INT             NULL,
    [DateLiveScheduledOriginal] DATE            NULL,
    [DateLiveScheduled]         DATE            NULL,
    [DateBillingStart]          DATE            NULL,
    [DateBillingStopped]        DATE            NULL,
    [OrderedById]               INT             NULL,
    [ProjectManagerId]          INT             NULL,
    [SalesPersonId]             INT             NULL,
    [ContractNumber]            NVARCHAR (16)   NULL,
    [LichenQuoteId]             INT             NULL,
    [LinkedOrderId]             INT             NULL,
    [IsAutoCommit]              BIT             NOT NULL,
    [IsWebOrder]                BIT             NOT NULL,
    [CloseReasonId]             INT             NULL,
    [LichenOrderId]             INT             NULL,
    [SalesForceId]              NVARCHAR (18)   NULL,
    [DateCreatedOriginal]       DATETIME2 (4)   NULL,
    [CreatedByPersonId]         INT             NULL,
    [DateModifiedOriginal]      DATETIME2 (4)   NULL,
    [ModifiedByPersonId]        INT             NULL,
    [DateModified]              DATETIME2 (4)   NOT NULL,
    [DateCreated]               DATETIME2 (4)   NOT NULL,
    [ModifiedBy]                NVARCHAR (50)   NOT NULL,
    [OtherEmails]               NVARCHAR (2000) NULL,
    [MasterOrderId]             INT             NULL,
    [OrderRequestSourceId]      INT             NULL,
    [CaseNumber]                INT             NULL,
    [OrderSubtypeId]            INT             NULL,
    [ClientProgrammerId]        INT             NULL,
    [DataEngineerId]            INT             NULL,
    [InFirstCOntract]           BIT             CONSTRAINT [DF_Order_InFirstCOntract] DEFAULT ((0)) NOT NULL,
    [SalesContractId]           INT             NULL,
    [IsEnforcementBypassed]     BIT             CONSTRAINT [DF_Order_IsEnforcementBypassed] DEFAULT ((0)) NOT NULL,
    [MasterOrderTypeId]         INT             NULL,
    [DeprovisionDate]           DATETIME2 (7)   NULL,
    [OrderSalesContractId]      INT             NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NCIX_oss_Order_ProjectManagerId]
    ON [oss].[Order]([ProjectManagerId] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIX_oss_Order_CreatedByPersonId]
    ON [oss].[Order]([CreatedByPersonId] ASC);

