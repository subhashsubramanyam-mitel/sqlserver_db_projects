


CREATE VIEW [dbo].[V_Forecast_Billings]
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
--and sc.[Fiscal Quarter] = 'FY15-Q4'
--and [WeekBucket] = 11
group by  [Fiscal Quarter],[WeekBucket], sc.Date

