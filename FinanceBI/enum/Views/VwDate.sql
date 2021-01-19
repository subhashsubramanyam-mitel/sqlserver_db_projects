

CREATE View [enum].[VwDate] as
select D.*,  coalesce(AD.NumInvoicesAgo,0)NumInvoicesAgo, 
coalesce(AD.NumMonthsAgo,0)NumMonthsAgo, coalesce(AD.NumWeeksAgo,0)NumWeeksAgo,  
AD.[FY Month#], AD.[FY Quarter#], AD.[FY Week#],
NM.[Quarter] PMQuarter 
from enum.DimDate D
inner join (select getdate() today) DT on 1=1
left join enum.VwAxDate2 AD on AD.[Date] = D.[Date]
left join enum.DimDate NM on NM.[Date] = DATEADD(month, -1, D.[Month])

