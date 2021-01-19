CREATE TABLE [dbo].[Forecast_Bookings_Summary] (
    [Fiscal Quarter]                          VARCHAR (50)    NULL,
    [WeekBucket]                              INT             NULL,
    [Total Booked]                            NUMERIC (29, 2) NULL,
    [PrevYearRatio]                           INT             NULL,
    [PrevQuarterRatio]                        INT             NULL,
    [Shoretel Business days Remaining in QTR] INT             NULL
);

