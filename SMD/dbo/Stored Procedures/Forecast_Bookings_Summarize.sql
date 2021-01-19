


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Forecast_Bookings_Summarize]
AS
BEGIN

	SET NOCOUNT ON;

Declare @currentQuarter varchar(7)
Declare @PreviousQuarter varchar(7)
Declare @PreviousYear varchar(7)
Declare @PrevQuarterRatio int
Declare @PrevYearRatio int
Declare @currentWeekBucket int
Declare @CurrentDay date
declare @shoretelDayNoOfQuarter int
Declare @PrevQuarterBooked numeric(11,2)
declare @PrevYearBooked numeric(11,2)
Declare @CurrentDayoftheWeekBucket int


select @currentQuarter = 
 a.[Fiscal Quarter]
from [V_Forecast_Billings] a
where
(datepart(qq, a.Date) = (datepart(qq, getdate())) and datepart(yy, a.date) = (datepart(yy, getdate())))

select @PreviousQuarter = a.[Fiscal Quarter]
from  [V_Forecast_Bookings]  a
where
(
datepart(qq, a.Date) = ( select case datepart(QQ, getdate()) - 1 when 0 then 4 else datepart(QQ, getdate()) - 1 end )
and 
datepart(yy, a.date) = (select case datepart(QQ, getdate()) - 1 when 0 then (datepart(yy, getdate() ) -1) else datepart(yy, getdate())
	                   end )
)

select @PreviousYear = a.[Fiscal Quarter]
from  [V_Forecast_Bookings]  a
where (
datepart(qq, a.Date) = (datepart(qq, getdate()))  and datepart(yy, a.date) = (datepart(yy, getdate())-1))

-------------------
select @CurrentDay = max(vb.date) from   [V_Forecast_Bookings] vb
join SalesCalendar sc
on vb.Date = sc.Date
where [SumOfNetBookedUSD] is not null and vb.[Fiscal Quarter] = @currentQuarter
and vb.date<>convert(date, getdate())
and sc.IsWeekday = 1

 set @currentWeekBucket = 
(select max(weekbucket) from  [V_Forecast_Bookings] where [SumOfNetBookedUSD] is not null and [Fiscal Quarter] = @currentQuarter and date = @CurrentDay)


select @shoretelDayNoOfQuarter = [ShoretelDayNoOfQuarter]  from SalesCalendar where date = @CurrentDay
---------
select @CurrentDayoftheWeekBucket = count(*) from SalesCalendar where date<= @CurrentDay and [Fiscal Quarter] = @currentQuarter
and WeekBucket = @currentWeekBucket and IsWeekday = 1
--------
select @PrevQuarterBooked = sum([SumOfNetBookedUSD]) from  [V_Forecast_Bookings]  where [Fiscal Quarter] = @PreviousQuarter
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket, date, IsBusinessDay from salescalendar
where [Fiscal Quarter] = @PreviousQuarter and weekbucket = @currentWeekBucket and IsWeekday = 1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)

--(select max(date) from SalesCalendar where [ShoretelDayNoOfQuarter] <= @shoretelDayNoOfQuarter and [Fiscal Quarter] = @PreviousQuarter
--and WeekBucket = @currentWeekBucket
--)

select @PrevYearBooked = sum([SumOfNetBookedUSD]) from  [V_Forecast_Bookings]  where [Fiscal Quarter] = @PreviousYear
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket,date,IsBusinessDay from salescalendar
where [Fiscal Quarter] = @PreviousYear and weekbucket = @currentWeekBucket and IsWeekday = 1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)

--(select max(date) from SalesCalendar where [ShoretelDayNoOfQuarter] <= @shoretelDayNoOfQuarter and [Fiscal Quarter] = @PreviousYear

--and  weekbucket = @currentWeekBucket)

-----------------------
DECLARE @forecast table(
[Fiscal Quarter] varchar(7),
[WeekBucket] int,
[WeeklyBooked] numeric(29,2),
[Total Booked] numeric(29,2)
)
insert into @forecast
SELECT a.[Fiscal Quarter],a.[WeekBucket],sum(a.[SumOfNetBookedUSD]) 'WeeklyBooked',
 (SELECT SUM(b.[SumOfNetBookedUSD])
                       FROM  [V_Forecast_Bookings]  b
                       WHERE b.[WeekBucket] <= a.[WeekBucket] and b.[Fiscal Quarter] = a.[Fiscal Quarter]
					   and date<= @CurrentDay 
                       ) as 'Total Booked'
					
--,
FROM   [dbo]. [V_Forecast_Bookings] a
WHERE
a.[Fiscal Quarter] in ( @currentQuarter, @PreviousQuarter, @PreviousYear)
and date<= @CurrentDay 
 GROUP BY a.[Fiscal Quarter],a.[WeekBucket]

 set @currentWeekBucket = 
(select max(weekbucket) from  @forecast where [Total Booked] is not null and [Fiscal Quarter] = @currentQuarter )


set @PrevQuarterRatio = 
(
(select [Total Booked] from  @forecast where [Fiscal Quarter] = @currentQuarter and [Total Booked] is not null 
and [WeekBucket]=  @currentWeekBucket
)
/
@PrevQuarterBooked
--(select [Total Booked] from  @forecast where [Fiscal Quarter] = @PreviousQuarter 
--and [WeekBucket]=  @currentWeekBucket
--)
) *100

set @PrevYearRatio = 

(
(select [Total Booked] from  @forecast where [Fiscal Quarter] = @currentQuarter and [Total Booked] is not null 
and [WeekBucket]=  @currentWeekBucket
)
/@PrevYearBooked
--(select [Total Booked] from  @forecast where [Fiscal Quarter] = @PreviousYear 
--and [WeekBucket]=  @currentWeekBucket
--)
) *100



-- MW 12042017 doing truncate here
truncate table  [Forecast_Bookings_Summary]


insert into [Forecast_Bookings_Summary]
 ([Fiscal Quarter]
  ,[WeekBucket]
  ,[Total Booked]
    )
select
[Fiscal Quarter] ,
[WeekBucket] ,
[Total Booked] 
from @forecast

---------------------------------
Update [Forecast_Bookings_Summary]
set [Total Booked] = @PrevQuarterBooked
where [Fiscal Quarter]  = @PreviousQuarter
and [WeekBucket] = @currentWeekBucket

update [Forecast_Bookings_Summary]
set [Shoretel Business days Remaining in QTR]
= (select
(
select sum([IsWeekday]) from SalesCalendar where [Fiscal Quarter] = @currentQuarter
)
-
(
select isnull(sum([IsWeekday]),0) from SalesCalendar
where [Fiscal Quarter] = @currentQuarter and [WeekBucket] <= (@currentWeekBucket -1)
)
- @CurrentDayoftheWeekBucket
--(
--select sum([IsWeekday]) from  [dbo].[SalesCalendar] 
--where  [Fiscal Quarter] = @currentQuarter  and [WeekBucket] = @currentWeekBucket  and date <= @CurrentDay
-- )
 )
 where [Fiscal Quarter] in ( @PreviousQuarter, @PreviousYear,  @currentQuarter)


Update [Forecast_Bookings_Summary]
set [Total Booked] = @PrevYearBooked
where [Fiscal Quarter]  = @PreviousYear
and [WeekBucket] = @currentWeekBucket

---------------------------------------

insert into [Forecast_Bookings_Summary]
 ([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio])
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket
,  ((select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] =  @PreviousQuarter and f1.[WeekBucket] = sc.WeekBucket)* @PrevQuarterRatio )/100
,0 as 'PrevYearRatio'
,@PrevQuarterRatio as 'PrevQuarterRatio'
from  [dbo].[SalesCalendar] sc
left outer join  @forecast f
on f.[WeekBucket] = sc.WeekBucket and  f.[Fiscal Quarter] = @currentQuarter
where 
(
f.WeekBucket is null
and
 sc.WeekBucket is not null
 )
 or
(
 f.weekbucket = 13
and
 sc.WeekBucket =13
 )


insert into [Forecast_Bookings_Summary]
 ([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio])
select distinct 'Projection based on '+@PreviousYear+ ' Run rate',sc.WeekBucket,  ((select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @PreviousYear and f1.[WeekBucket] = sc.WeekBucket)* @PrevYearRatio )/100
,@PrevYearRatio as 'PrevYearRatio'
,0 as 'PrevQuarterRatio'
from  [dbo].[SalesCalendar] sc
left outer join  @forecast f
on f.[WeekBucket] = sc.WeekBucket and   f.[Fiscal Quarter] = @currentQuarter 
where (
f.WeekBucket is null
and
 sc.WeekBucket is not null
 )
 or
(
 f.weekbucket = 13
and
 sc.WeekBucket =13
 )
--Forecast for current Quarter
insert into [Forecast_Bookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
          		   )
select distinct 'Projection based on '+@PreviousYear+ ' Run rate',sc.WeekBucket, 
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
)
from  [dbo].[SalesCalendar] sc

where 
sc.WeekBucket = @currentWeekBucket and sc.WeekBucket <> 13

insert into [Forecast_Bookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]

)
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket,
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
)
from  [dbo].[SalesCalendar] sc

where 
sc.WeekBucket = @currentWeekBucket and sc.WeekBucket <> 13

END













