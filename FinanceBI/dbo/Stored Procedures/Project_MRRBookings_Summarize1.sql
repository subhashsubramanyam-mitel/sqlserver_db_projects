


-- =============================================
-- Author:		<Payal Mukhi>
-- Create date: <05/24/2016>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Project_MRRBookings_Summarize1]
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


DECLARE @Project_MRRBookings table
(
[WeekBucket] int,
[Fiscal Quarter] varchar(7),
Date date,
SumOfNetMRRBookedUSD numeric(29,2)
)
insert into @Project_MRRBookings
select 
[WeekBucket]
,[Fiscal Quarter]
,sc.Date
,sum([Bookings]) as 'SumOfNetMRRBookedUSD'
from [rollup].[VwTotalBookings] mrr
--from [dbo].[POS_AXBILLINGS_COMBINED] pos
join (select date, [WeekBucket], [Fiscal Quarter] from [SMD].[SMD].[dbo].SalesCalendar) sc
on mrr.[Bookings Date] = sc.date
where mrr.[Bookings Date] >= '2015-01-01'
group by  [Fiscal Quarter],[WeekBucket], sc.Date


select @currentQuarter = 
 a.[Fiscal Quarter]
from @Project_MRRBookings a
where
(datepart(qq, a.Date) = (datepart(qq, getdate())) and datepart(yy, a.date) = (datepart(yy, getdate())))
print @currentQuarter

select @PreviousQuarter = a.[Fiscal Quarter]
from  @Project_MRRBookings  a
where
(
datepart(qq, a.Date) = ( select case datepart(QQ, getdate()) - 1 when 0 then 4 else datepart(QQ, getdate()) - 1 end )
and 
datepart(yy, a.date) = (select case datepart(QQ, getdate()) - 1 when 0 then (datepart(yy, getdate() ) -1) else datepart(yy, getdate())
	                   end )
)



select @PreviousYear = a.[Fiscal Quarter]
from  @Project_MRRBookings  a
where (
datepart(qq, a.Date) = (datepart(qq, getdate()))  and datepart(yy, a.date) = (datepart(yy, getdate())-1))

-------------------
select @CurrentDay = max(vb.date) from   @Project_MRRBookings vb
join [SMD].[SMD].[dbo].SalesCalendar sc
on vb.Date = sc.Date
 where [SumOfNetMRRBookedUSD] is not null and vb.[Fiscal Quarter] = @currentQuarter
 and vb.date<>convert(date, getdate())
and sc.IsWeekday = 1

 set @currentWeekBucket = 
(select max(weekbucket) from  @Project_MRRBookings  where [SumOfNetMRRBookedUSD] is not null and [Fiscal Quarter] = @currentQuarter and date = @CurrentDay )

select @shoretelDayNoOfQuarter = [ShoretelDayNoOfQuarter]  from [SMD].[SMD].[dbo].SalesCalendar where date = @CurrentDay
---------
select @CurrentDayoftheWeekBucket = count(*) from [SMD].[SMD].[dbo].SalesCalendar where date<= @CurrentDay and [Fiscal Quarter] = @currentQuarter
and WeekBucket = @currentWeekBucket and IsWeekday =1
--------

select @PrevQuarterBooked = sum([SumOfNetMRRBookedUSD]) from  @Project_MRRBookings   where [Fiscal Quarter] = @PreviousQuarter
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket,date,IsBusinessDay from [SMD].[SMD].[dbo].SalesCalendar
where [Fiscal Quarter] = @PreviousQuarter and weekbucket = @currentWeekBucket and IsWeekday =1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)


select @PrevYearBooked = sum([SumOfNetMRRBookedUSD]) from @Project_MRRBookings   where [Fiscal Quarter] = @PreviousYear
and date <=
(
Select date from (
select rank() OVER (Order by date) as rank, WeekBucket,date,IsBusinessDay from [SMD].[SMD].[dbo].SalesCalendar
where [Fiscal Quarter] = @PreviousYear and weekbucket = @currentWeekBucket and IsWeekday =1
) DayoftheWeekBucket
where rank = @CurrentDayoftheWeekBucket
)



print @PrevQuarterBooked
print @PrevYearBooked

-----------------------
DECLARE @forecast table(
[Fiscal Quarter] varchar(7),
[WeekBucket] int,
[WeeklyBooked] numeric(29,2),
[Total Booked] numeric(29,2)
)
insert into @forecast
SELECT a.[Fiscal Quarter],a.[WeekBucket],sum(a.[SumOfNetMRRBookedUSD]) 'WeeklyBooked',
 (SELECT SUM(b.[SumOfNetMRRBookedUSD])
                       FROM  @Project_MRRBookings  b
                       WHERE b.[WeekBucket] <= a.[WeekBucket] and b.[Fiscal Quarter] = a.[Fiscal Quarter]
					   and date<= @CurrentDay 
                       ) as 'Total Booked'
					
--,
FROM   @Project_MRRBookings  a
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

insert into [Project_MRRBookings_Summary]
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
Update [Project_MRRBookings_Summary]
set [Total Booked] = @PrevQuarterBooked
where [Fiscal Quarter]  = @PreviousQuarter
and [WeekBucket] = @currentWeekBucket

update [Project_MRRBookings_Summary]
set [Shoretel Business days Remaining in QTR]
=(select
(
select sum([IsWeekday]) from [SMD].[SMD].[dbo].SalesCalendar where [Fiscal Quarter] = @currentQuarter
)
-
(
select sum([IsWeekday]) from [SMD].[SMD].[dbo].SalesCalendar
where [Fiscal Quarter] = @currentQuarter and [WeekBucket] <= (@currentWeekBucket -1)
)

- @CurrentDayoftheWeekBucket
--(
--select sum([IsWeekday]) from  [dbo].[SalesCalendar] 
--where  [Fiscal Quarter] = @currentQuarter  and [WeekBucket] = @currentWeekBucket  and date <= @CurrentDay
-- )
 )
 where [Fiscal Quarter] in ( @PreviousQuarter, @PreviousYear,  @currentQuarter)


Update [Project_MRRBookings_Summary]
set [Total Booked] = @PrevYearBooked
where [Fiscal Quarter]  = @PreviousYear
and [WeekBucket] = @currentWeekBucket




---------------------------------------

insert into [Project_MRRBookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio])
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket
,  ((select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] =  @PreviousQuarter and f1.[WeekBucket] = sc.WeekBucket)* @PrevQuarterRatio )/100
--,@PrevYearRatio as 'PrevYearRatio'
,0 as 'PrevYearRatio'
,@PrevQuarterRatio as 'PrevQuarterRatio'
from  [SMD].[SMD].[dbo].SalesCalendar sc
left outer join  @forecast f
on f.[WeekBucket] = sc.WeekBucket and  f.[Fiscal Quarter] = @currentQuarter
where 
(
f.WeekBucket is null
and sc.WeekBucket is not null
)
 or
(
 f.weekbucket = 13
and
 sc.WeekBucket =13
 )


 ----------------
 
insert into [Project_MRRBookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
           ,[PrevYearRatio]
           ,[PrevQuarterRatio]
		   )
select distinct 'Projection based on '+@PreviousYear+ ' Run rate',sc.WeekBucket,  ((select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @PreviousYear and f1.[WeekBucket] = sc.WeekBucket)* @PrevYearRatio )/100
,@PrevYearRatio as 'PrevYearRatio'
,0 as 'PrevQuarterRatio'
--,@PrevQuarterRatio as 'PrevQuarterRatio'
from  [SMD].[SMD].[dbo].SalesCalendar sc
left outer join  @forecast f
on f.[WeekBucket] = sc.WeekBucket and   f.[Fiscal Quarter] = @currentQuarter 
where 
(
f.WeekBucket is null
and sc.WeekBucket is not null
)
or
(
 f.weekbucket = 13
and
 sc.WeekBucket =13
 )


insert into [Project_MRRBookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
          		   )
select distinct 'Projection based on '+@PreviousYear+ ' Run rate',sc.WeekBucket, 
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
)
from  [SMD].[SMD].[dbo].SalesCalendar sc
where 
sc.WeekBucket = @currentWeekBucket and sc.WeekBucket <> 13

insert into [Project_MRRBookings_Summary]
([Fiscal Quarter]
           ,[WeekBucket]
           ,[Total Booked]
		 
)
select distinct 'Projection based on '+@PreviousQuarter+ ' Run rate', sc.WeekBucket,
(select f1.[Total Booked] from @forecast f1 where f1.[Fiscal Quarter] = @currentQuarter and [WeekBucket] = @currentWeekBucket
)

from  [SMD].[SMD].[dbo].SalesCalendar sc

where 
sc.WeekBucket = @currentWeekBucket
and sc.WeekBucket <> 13

END









