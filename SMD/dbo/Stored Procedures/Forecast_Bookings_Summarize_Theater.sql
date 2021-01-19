


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Forecast_Bookings_Summarize_Theater]
AS
BEGIN

	SET NOCOUNT ON;

Declare @currentQuarter varchar(7)
Declare @PreviousQuarter varchar(7)
Declare @PreviousYear varchar(7)
--Declare @PrevQuarterRatio int
Declare @PrevYearRatio int
Declare @currentWeekBucket int
Declare @CurrentDay date
declare @shoretelDayNoOfQuarter int
--Declare @PrevQuarterBooked numeric(11,2)
--declare @PrevYearBooked numeric(11,2)
Declare @CurrentDayoftheWeekBucket int


declare @PrevQuarterBooked table
(
PrevQuarterBooked numeric(11,2),
theater varchar(100),
PrevQuarterRatio int
)

declare @PrevYearBooked table
(
PrevYearBooked numeric(11,2),
theater varchar(100),
PrevYearRatio int
)

DECLARE @Forecast_Bookings_theater table
(
[WeekBucket] int,
[Fiscal Quarter] varchar(7),
Date date,
SumOfNetBookedUSD numeric(29,2),
Theater varchar(100)
)

insert into @Forecast_Bookings_theater
select 
[WeekBucket]
 ,[Fiscal Quarter]
 ,sc.Date
,sum([NetSalesUSD]) as 'SumOfNetBookedUSD'
,case when ter.theater is null then t.Theatre
 else ter.theater
 end as 'theater'

from [dbo].[POS_AXBILLINGS_COMBINED] pos
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on pos.InvoiceDate_DateFormat = sc.date
left outer join [sfdc_customers] ter
on ter.ImpactNumber COLLATE Latin1_General_CI_AS  = pos.ImpactNumber
left outer join [CORPDB].[STDW].dbo.ZipCodeMap z 
on z.zipcode COLLATE Latin1_General_CI_AS = pos.ShipPostalCode 
left outer join SFDC_TERRITORY t
on t.AXCode COLLATE Latin1_General_CI_AS = z.area COLLATE Latin1_General_CI_AS
where 
[RevType] in ('Product', 'service', 'support', 'freight')
and pos.impactnumber not in ('51746','716880','736458','735129') 
and source = 'POS'
--and sc.[Fiscal Quarter] = 'FY15-Q4'
--and [WeekBucket] = 11
group by  [Fiscal Quarter],[WeekBucket], sc.Date
, 
(
case when ter.theater is null then t.Theatre
 else ter.theater
 end 
 ) 

union all

select
[WeekBucket]
, [Fiscal Quarter]
,sc.Date
,sum([BookedUSD]) as 'SumOfNetBookedUSD'
,case when ter.theater is null then t.Theatre
 else ter.theater
 end as 'theater'
from
[dbo].[AX_BOOKINGS] ab
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on ab.[OrderDate_DateFormat] = sc.date
left outer join [sfdc_customers] ter
on ter.ImpactNumber COLLATE Latin1_General_CI_AS  = ab.BillTo
left outer join [CORPDB].[STDW].dbo.ZipCodeMap z 
on z.zipcode COLLATE Latin1_General_CI_AS = ab.ShipPostalCode
left outer join SFDC_TERRITORY t
on t.AXCode COLLATE Latin1_General_CI_AS = z.area COLLATE Latin1_General_CI_AS
where 
[AxRevType] in (1,2,3,4)
and billto not in ('51746','716880','736458','735129') 
--and sc.[Fiscal Quarter] = 'FY15-Q4'
--and [WeekBucket] = 11
group by  [Fiscal Quarter],[WeekBucket], sc.Date
, 
(
case when ter.theater is null then t.Theatre
 else ter.theater
 end 
 ) 


-------------------


select @currentQuarter = 
 a.[Fiscal Quarter]
from @Forecast_Bookings_theater a
where
(datepart(qq, a.Date) = (datepart(qq, getdate())) and datepart(yy, a.date) = (datepart(yy, getdate())))

select @PreviousQuarter = a.[Fiscal Quarter]
from   @Forecast_Bookings_theater a
where
(
datepart(qq, a.Date) = ( select case datepart(QQ, getdate()) - 1 when 0 then 4 else datepart(QQ, getdate()) - 1 end )
and 
datepart(yy, a.date) = (select case datepart(QQ, getdate()) - 1 when 0 then (datepart(yy, getdate() ) -1) else datepart(yy, getdate())
	                   end )
)

select @PreviousYear = a.[Fiscal Quarter]
from  @Forecast_Bookings_theater a
where (
datepart(qq, a.Date) = (datepart(qq, getdate()))  and datepart(yy, a.date) = (datepart(yy, getdate())-1))

-------------------
select @CurrentDay = max(vb.date) from   @Forecast_Bookings_theater vb
join SalesCalendar sc
on vb.Date = sc.Date
where [SumOfNetBookedUSD] is not null and vb.[Fiscal Quarter] = @currentQuarter
and vb.date<>convert(date, getdate())
and sc.IsWeekday = 1

 set @currentWeekBucket = 
(select max(weekbucket) from   @Forecast_Bookings_theater where [SumOfNetBookedUSD] is not null and [Fiscal Quarter] = @currentQuarter and date = @CurrentDay)


select @shoretelDayNoOfQuarter = [ShoretelDayNoOfQuarter]  from SalesCalendar where date = @CurrentDay
---------
select @CurrentDayoftheWeekBucket = count(*) from SalesCalendar where date<= @CurrentDay and [Fiscal Quarter] = @currentQuarter
and WeekBucket = @currentWeekBucket and IsWeekday = 1
--------

insert into @PrevQuarterBooked
(
PrevQuarterBooked ,
theater
)
select sum([SumOfNetBookedUSD]), Theater from   @Forecast_Bookings_theater   where [Fiscal Quarter] = @PreviousQuarter
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket,date,IsBusinessDay from salescalendar
where [Fiscal Quarter] = @PreviousQuarter and weekbucket = @currentWeekBucket and IsWeekday =1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)
group by Theater


insert into @PrevYearBooked
(
PrevYearBooked,
theater
)
select sum([SumOfNetBookedUSD]), Theater from @Forecast_Bookings_theater  where [Fiscal Quarter] = @PreviousYear
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket,date,IsBusinessDay from salescalendar
where [Fiscal Quarter] = @PreviousYear and weekbucket = @currentWeekBucket and IsWeekday =1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)
group by Theater



---------------------
DECLARE @forecast table(
[Fiscal Quarter] varchar(7),
[WeekBucket] int,
[WeeklyBooked] numeric(29,2),
[Total Booked] numeric(29,2),
[Theater] varchar(100)
)
insert into @forecast
SELECT a.[Fiscal Quarter],a.[WeekBucket],sum(a.[SumOfNetBookedUSD]) 'WeeklyBooked',
 (SELECT SUM(b.[SumOfNetBookedUSD])
                       FROM  @Forecast_Bookings_theater  b
                       WHERE b.[WeekBucket] <= a.[WeekBucket] and b.[Fiscal Quarter] = a.[Fiscal Quarter]
					   and date<= @CurrentDay 
					     and theater = a.Theater
					   group by Theater
                       ) as 'Total Booked'
					
, a.[Theater]
FROM   @Forecast_Bookings_theater a
WHERE
a.[Fiscal Quarter] in ( @currentQuarter, @PreviousQuarter, @PreviousYear)
and date<= @CurrentDay 
and Theater is not NULL
 GROUP BY a.[Fiscal Quarter],a.[WeekBucket], a.[Theater]

 set @currentWeekBucket = 
(select max(weekbucket) from  @forecast where [Total Booked] is not null and [Fiscal Quarter] = @currentQuarter )


update p
set p.PrevQuarterRatio =  ([Total Booked]/p.PrevQuarterBooked) * 100
from  @forecast f
join @PrevQuarterBooked p
on f.Theater = p.theater
 where f.[Fiscal Quarter] = @currentQuarter --and f.[Total Booked] is not null 
and f.[WeekBucket]=  @currentWeekBucket

update y
set y.PrevYearRatio =  ([Total Booked]/y.PrevYearBooked) * 100
from  @forecast f
join @PrevYearBooked y
on f.Theater = y.theater
 where f.[Fiscal Quarter] = @currentQuarter and f.[Total Booked] is not null 
and f.[WeekBucket]=  @currentWeekBucket



insert into [Forecast_Bookings_Summary_Theater]
 ([Fiscal Quarter]
  ,[WeekBucket]
  ,[Total Booked]
   ,[Theater]
    )
select
[Fiscal Quarter] ,
[WeekBucket] ,
[Total Booked],
Theater 
from @forecast

---------------------------------
Update [Forecast_Bookings_Summary_Theater]
set [Total Booked] = p.PrevQuarterBooked
from @PrevQuarterBooked p
join [Forecast_Bookings_Summary_Theater] f
on p.theater = f.Theater
where [Fiscal Quarter]  = @PreviousQuarter
and [WeekBucket] = @currentWeekBucket
and f.theater = p.theater

update [Forecast_Bookings_Summary_Theater]
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
 )
 where [Fiscal Quarter] in ( @PreviousQuarter, @PreviousYear,  @currentQuarter)


Update [Forecast_Bookings_Summary_Theater]
set [Total Booked] = p.PrevYearBooked
from @PrevYearBooked p
join [Forecast_Bookings_Summary_Theater] f
on p.theater = f.Theater
where [Fiscal Quarter]  = @PreviousYear
and [WeekBucket] = @currentWeekBucket
and f.theater = p.theater

---------------------------------------

insert into  [Forecast_Bookings_Summary_Theater]
 ([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio]
		   ,theater)
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket
,  ((select f1.[Total Booked] 
      from @forecast f1 
	  where f1.[Fiscal Quarter] =  @PreviousQuarter and f1.[WeekBucket] = sc.WeekBucket and f1.theater = p.theater
	 )
	  * (select PrevQuarterRatio from @PrevQuarterBooked p1 where p1.theater = p.Theater)
   )
	/100

,0 as 'PrevYearRatio'
,p.PrevQuarterRatio as 'PrevQuarterRatio'
, p.theater
from  [dbo].[SalesCalendar] sc
left outer join  @forecast f
on f.[WeekBucket] = sc.[WeekBucket] and  f.[Fiscal Quarter] = @currentQuarter 
cross join @PrevQuarterBooked p 

where 
 p.theater is not null
 and
(
f.WeekBucket is null and sc.weekbucket is not null
)
 or
(
 f.weekbucket = 13 and  sc.WeekBucket =13
 )


insert into  [Forecast_Bookings_Summary_Theater]
 ([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio]
		   , theater)
select distinct 'Projection based on '+@PreviousYear+ ' Run rate', sc.WeekBucket
,  ((select f1.[Total Booked] 
      from @forecast f1 
	  where f1.[Fiscal Quarter] =  @PreviousYear and f1.[WeekBucket] = sc.WeekBucket and f1.theater = p.theater
	 )
	  * (select PrevYearRatio from @PrevYearBooked p1 where p1.theater = p.Theater)
   )
	/100

,p.PrevYearRatio as 'PrevYearRatio'
,0 as 'PrevQuarterRatio'
, p.theater
from  [dbo].[SalesCalendar] sc
left outer join  @forecast f
on f.[WeekBucket] = sc.[WeekBucket] and  f.[Fiscal Quarter] = @currentQuarter 
cross join @PrevYearBooked p 

where 
 p.theater is not null
 and
( f.WeekBucket is null and sc.weekbucket is not null )
 or
(  f.weekbucket = 13 and sc.WeekBucket =13 )

--Forecast for current Quarter
insert into [Forecast_Bookings_Summary_Theater]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
		   ,Theater
          		   )
select distinct 'Projection based on '+@PreviousYear+ ' Run rate',sc.WeekBucket, 
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
and f.Theater = f1.Theater
)
,f.theater
from  [dbo].[SalesCalendar] sc
join @forecast f 
on sc.weekbucket = f.WeekBucket

insert into [Forecast_Bookings_Summary_Theater]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
		   ,theater
)
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket,
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
and f.Theater = f1.Theater
)
,f.theater
from  [dbo].[SalesCalendar] sc
join @forecast f 
on sc.weekbucket = f.WeekBucket
where 
sc.WeekBucket = @currentWeekBucket and sc.WeekBucket <> 13

END
