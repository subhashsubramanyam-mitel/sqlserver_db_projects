CREATE TABLE [dbo].[SFDC_FORECASTING_ITEM] (
    [Created]                          DATETIME      CONSTRAINT [DF_SFDC_FORECASTING_FACT_Created] DEFAULT (getdate()) NOT NULL,
    [Id]                               VARCHAR (18)  NOT NULL,
    [ForecastCategoryName]             VARCHAR (25)  NULL,
    [OpportunityId]                    VARCHAR (18)  NULL,
    [OwnerId]                          VARCHAR (18)  NULL,
    [ForecastingItemId]                VARCHAR (18)  NULL,
    [ForecastType]                     VARCHAR (100) NULL,
    [ForecastAmount]                   FLOAT (53)    NULL,
    [ForecastAmountWithoutAdjustments] FLOAT (53)    NULL,
    [Period]                           VARCHAR (100) NULL,
    CONSTRAINT [PK_SFDC_FORECASTING_FACT] PRIMARY KEY CLUSTERED ([Id] ASC)
);

