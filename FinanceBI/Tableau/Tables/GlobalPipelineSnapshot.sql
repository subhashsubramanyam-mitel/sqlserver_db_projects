CREATE TABLE [Tableau].[GlobalPipelineSnapshot] (
    [Id]                      BIGINT          IDENTITY (11000000, 1) NOT NULL,
    [ReportDate]              DATETIME        NOT NULL,
    [OrderId]                 INT             NULL,
    [Ac Name]                 NVARCHAR (120)  NULL,
    [BillingStage]            VARCHAR (17)    NULL,
    [Cluster]                 NCHAR (100)     NULL,
    [ContractCreateDate]      DATETIME2 (7)   NULL,
    [ContractNumber]          NVARCHAR (16)   NULL,
    [ContractProfileAmount]   INT             NULL,
    [ContractStartDate]       DATE            NULL,
    [ContractType]            NVARCHAR (100)  NULL,
    [DateSvcLiveActual]       DATE            NULL,
    [ForecastDate]            DATE            NULL,
    [IsBillable]              INT             NULL,
    [Loc Name]                NVARCHAR (200)  NULL,
    [LocationState]           NVARCHAR (100)  NULL,
    [MasterOrderType]         NVARCHAR (50)   NULL,
    [OppCloseDate]            DATE            NULL,
    [OpportunityNumber]       VARCHAR (100)   COLLATE Latin1_General_BIN NULL,
    [Order PM]                NVARCHAR (241)  NULL,
    [OrderStatus]             NVARCHAR (20)   NULL,
    [OrderType]               NVARCHAR (50)   NULL,
    [OrderDate]               DATETIME2 (4)   NULL,
    [Platform]                NVARCHAR (20)   NULL,
    [Prod Category]           NVARCHAR (50)   NULL,
    [Prod Name]               NVARCHAR (128)  NULL,
    [Prod ShortName]          NVARCHAR (128)  NULL,
    [ProjectDelayDescription] VARCHAR (255)   COLLATE Latin1_General_BIN NULL,
    [ProjectDelayReason]      VARCHAR (255)   COLLATE Latin1_General_BIN NULL,
    [ProjectOwnerName]        VARCHAR (250)   COLLATE Latin1_General_BIN NULL,
    [Region]                  VARCHAR (2)     NOT NULL,
    [ServiceStatus]           NVARCHAR (128)  NULL,
    [VoidDate]                DATE            NULL,
    [MonthlyCharge]           NUMERIC (38, 6) NULL,
    [OneTimeCharge]           NUMERIC (38, 6) NULL,
    [SeatCount]               INT             NULL,
    [OppProfileAmount]        FLOAT (53)      NULL,
    [BusinessTermVersion]     VARCHAR (50)    NULL,
    [TF_EndDate]              DATETIME        NULL,
    [ServiceCommitmentDate]   DATETIME        NULL,
    CONSTRAINT [PK_GlobalPipelineSnapshot] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [NC_IX_GlobalPipelineSnapshot_ReportDate]
    ON [Tableau].[GlobalPipelineSnapshot]([ReportDate] ASC) WITH (FILLFACTOR = 80);

