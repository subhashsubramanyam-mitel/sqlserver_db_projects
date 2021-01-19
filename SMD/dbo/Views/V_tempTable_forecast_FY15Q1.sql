CREATE view  [dbo].[V_tempTable_forecast_FY15Q1]
As
select 
[WeekBucket]
 ,[Fiscal Quarter]
 ,sc.Date
 ,[NetSalesUSD]
--,sum([NetSalesUSD]) as 'SumOfNetBookedUSD'
,[SalesOrder]
from [dbo].[POS_AXBILLINGS_COMBINED] pos
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on pos.InvoiceDate_DateFormat = sc.date
where 
[RevType] in ('Product', 'service', 'support', 'freight')
and impactnumber not in ('51746','716880','736458','735129') 
and source = 'POS'
and sc.[Fiscal Quarter] = '2015-Q1'
--and [WeekBucket] in (1,2)
------group by  [Fiscal Quarter],[WeekBucket], sc.Date

union all

select
[WeekBucket]
, [Fiscal Quarter]
,sc.Date
 ,[BookedUSD]
--,sum([BookedUSD]) as 'SumOfNetBookedUSD'
,[SalesOrder]
from
[dbo].[AX_BOOKINGS] ab
join (select date, [WeekBucket], [Fiscal Quarter] from SalesCalendar) sc
on ab.[OrderDate_DateFormat] = sc.date
where 
[AxRevType] in (1,2,3,4)
and billto not in ('51746','716880','736458','735129') 
and sc.[Fiscal Quarter] = '2015-Q1'