CREATE TABLE [enum].[AxDate] (
    [Date]               DATE          NULL,
    [Old Calendar Month] NVARCHAR (32) NULL,
    [Old Fiscal Quarter] NVARCHAR (32) NULL,
    [Fiscal Year]        NVARCHAR (50) NULL,
    [Month]              AS            (CONVERT([date],[dbo].[UfnFirstOfMonth]([date]))),
    [Fiscal Quarter]     AS            (case when datepart(quarter,[Date])<(3) then (('FY'+substring(CONVERT([varchar],datepart(year,[Date]),(0)),(3),(2)))+'-Q')+CONVERT([varchar],datepart(quarter,[date])+(2),(0)) else (('FY'+substring(CONVERT([varchar],datepart(year,[Date])+(1),(0)),(3),(2)))+'-Q')+CONVERT([varchar],datepart(quarter,[date])-(2),(0)) end),
    [Calendar Month]     AS            ((CONVERT([varchar](4),datepart(year,[date]),(4))+'-M')+right('0'+CONVERT([varchar](2),datepart(month,[date]),(2)),(2))),
    [Fiscal Month]       AS            (([Fiscal Year]+'-M')+right('0'+CONVERT([varchar](2),case when datepart(month,[Date])>(6) then datepart(month,[Date])-(6) else datepart(month,[Date])+(6) end),(2))),
    [IsHoliday]          BIT           CONSTRAINT [DF_AxDate_IsHoliday] DEFAULT ((0)) NOT NULL,
    [IsBusinessDay]      AS            (case when [IsHoliday]=(1) then (0) when datepart(weekday,[Date])=(1) OR datepart(weekday,[Date])=(7) then (0) else (1) end),
    [FQ Week#]           AS            (right('0'+CONVERT([varchar](2),[dbo].[UfnWeekInQuarter]([Date])),(2))),
    [FY Month#]          AS            (right('0'+CONVERT([varchar](2),case when datepart(month,[Date])<(7) then datepart(month,[date])+(6) else datepart(month,[date])-(6) end),(2))),
    [FY Quarter#]        AS            (case when datepart(quarter,[Date])<(3) then datepart(quarter,[date])+(2) else datepart(quarter,[date])-(2) end),
    [FQ Week#NS]         AS            ([dbo].[UfnNSWeekInQuarter]([Date]))
);

