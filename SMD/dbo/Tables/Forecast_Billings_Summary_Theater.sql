CREATE TABLE [dbo].[Forecast_Billings_Summary_Theater] (
    [Fiscal Quarter]                          VARCHAR (50)    NULL,
    [WeekBucket]                              INT             NULL,
    [Total Booked]                            NUMERIC (29, 2) NULL,
    [PrevYearRatio]                           INT             NULL,
    [PrevQuarterRatio]                        INT             NULL,
    [Shoretel Business days Remaining in QTR] INT             NULL,
    [Theater]                                 VARCHAR (100)   NULL
);

