
CREATE VIEW [rollup].[V_Project_MRRBookings]
AS

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

