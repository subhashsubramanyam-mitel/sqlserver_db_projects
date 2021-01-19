CREATE TABLE [dbo].[SalesCalendar] (
    [Date]                   DATE          NULL,
    [Fiscal Year]            NVARCHAR (50) NULL,
    [IsHoliday]              BIT           CONSTRAINT [DF_AxDate_IsHoliday] DEFAULT ((0)) NOT NULL,
    [IsBusinessDay]          AS            (case when [IsHoliday]=(1) then (0) when datepart(weekday,[Date])>(5) then (0) else (1) end),
    [DayNoOfWeek]            INT           NULL,
    [DayOfWeek]              NVARCHAR (50) NULL,
    [CalendarWeekNo]         INT           NULL,
    [IsWeekday]              INT           NULL,
    [DaysOfMonth]            INT           NULL,
    [WeekBucket]             INT           NULL,
    [Fiscal Quarter]         AS            (case when datepart(quarter,[Date])<(3) then (CONVERT([varchar],datepart(year,[Date]),(0))+'-Q')+CONVERT([varchar],datepart(quarter,[Date])+(2),(0)) else (CONVERT([varchar],datepart(year,[Date])+(1),(0))+'-Q')+CONVERT([varchar],datepart(quarter,[Date])-(2),(0)) end),
    [ShoretelDayNoOfQuarter] INT           NULL
);

