CREATE TABLE [dbo].[SFDC_FORECASTING_SNAPSHOT] (
    [SnapDate]                         DATETIME      NULL,
    [Id]                               VARCHAR (28)  NOT NULL,
    [ForcastItemId]                    VARCHAR (18)  NOT NULL,
    [ForecastCategoryName]             VARCHAR (25)  NULL,
    [OwnerId]                          VARCHAR (18)  NULL,
    [ForecastType]                     VARCHAR (100) NULL,
    [ForecastAmount]                   FLOAT (53)    NULL,
    [ForecastAmountWithoutAdjustments] FLOAT (53)    NULL,
    [Period]                           VARCHAR (100) NULL,
    CONSTRAINT [PK_SFDC_FORECASTING_SNAPSHOT] PRIMARY KEY CLUSTERED ([Id] ASC)
);

