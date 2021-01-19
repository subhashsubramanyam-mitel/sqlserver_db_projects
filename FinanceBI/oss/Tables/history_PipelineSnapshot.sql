CREATE TABLE [oss].[history_PipelineSnapshot] (
    [DateOfSnapshot]                 DATE            NULL,
    [AccountId]                      INT             NOT NULL,
    [ServiceId]                      INT             NOT NULL,
    [ProductId]                      INT             NULL,
    [OrderId]                        INT             NULL,
    [OrderProjectManagerId]          INT             NULL,
    [OrderTypeId]                    INT             NULL,
    [ServiceStatusId]                INT             NOT NULL,
    [LocationId]                     INT             NULL,
    [Name]                           NVARCHAR (4000) NULL,
    [DateSvcVoided]                  DATE            NULL,
    [DateSvcActivated]               DATE            NULL,
    [DateSvcLiveScheduled_Yesterday] DATE            NULL,
    [ForecastChangedValue]           INT             NULL,
    [DateSvcLiveScheduled_Original]  DATE            NULL,
    [DateSvcLiveScheduled]           DATE            NULL,
    [DateSvcLiveActual]              DATE            NULL,
    [SvcCluster]                     NCHAR (100)     NULL,
    [SvcPlatform]                    NVARCHAR (20)   NULL,
    [BillingStage]                   VARCHAR (17)    NOT NULL,
    [MonthlyCharge]                  NUMERIC (38, 6) NULL,
    [OneTimeCharge]                  NUMERIC (38, 6) NULL,
    [IsMRRZero]                      VARCHAR (7)     NOT NULL,
    [DateSvcClosed]                  DATE            NULL,
    [DateSvcCreated]                 DATE            NULL,
    [DateSvcModified]                DATE            NULL,
    [ModifiedToday]                  INT             NOT NULL,
    [VoidedToday]                    INT             NOT NULL,
    [ActivatedToday]                 INT             NOT NULL,
    [LiveToday]                      INT             NOT NULL,
    [ForecastDelayedToday]           INT             NULL,
    [ForecastExpeditedToday]         INT             NULL,
    [DateLocLiveForecast]            DATE            NULL,
    [DateLocLiveForecast_Yesterday]  DATE            NULL,
    [DateLocLiveForecast_Original]   DATE            NULL
);


GO
CREATE CLUSTERED INDEX [IX_Clustered-DateOfSnapshot]
    ON [oss].[history_PipelineSnapshot]([DateOfSnapshot] ASC, [ServiceId] ASC);

