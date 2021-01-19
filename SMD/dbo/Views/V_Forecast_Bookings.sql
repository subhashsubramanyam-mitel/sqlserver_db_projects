

CREATE VIEW [dbo].[V_Forecast_Bookings]
AS

select 
[WeekBucket]
 ,[Fiscal Quarter]
 ,sc.Date
,sum([NetSalesUSD]) as 'SumOfNetBookedUSD'

from [dbo].[POS_AXBILLINGS_COMBINED] pos
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on pos.InvoiceDate_DateFormat = sc.date
where 
[RevType] in ('Product', 'service', 'support', 'freight')
and impactnumber not in ('51746','716880','736458','735129') 
and source = 'POS'
--and sc.[Fiscal Quarter] = 'FY15-Q4'
--and [WeekBucket] = 11
group by  [Fiscal Quarter],[WeekBucket], sc.Date

union all

select
[WeekBucket]
, [Fiscal Quarter]
,sc.Date
,sum([BookedUSD]) as 'SumOfNetBookedUSD'
from
[dbo].[AX_BOOKINGS] ab
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on ab.[OrderDate_DateFormat] = sc.date
where 
[AxRevType] in (1,2,3,4)
and billto not in ('51746','716880','736458','735129') 
--and sc.[Fiscal Quarter] = 'FY15-Q4'
--and [WeekBucket] = 11
group by  [Fiscal Quarter],[WeekBucket], sc.Date
