
  

CREATE VIEW [dbo].[V_Forecast_Bookings_Theater]
AS

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

