

CREATE VIEW [dbo].[V_Bombora_Analytics_withSalesRegion]
AS
select distinct 
bc.[Company Name]
      ,bc.[Domain]
      ,bc.[Company Size]
      --,bc.[Industry]
	  ,case when bc.industry like '%>%' then
SUBSTRING(bc.industry, (CHARINDEX('>', bc.industry)+1), LEN(bc.industry))
else bc.industry
end as Industry
,
case when bc.industry like '%>%' then substring(bc.industry, 1, ((charindex('>',bc.industry)-2)))
else '' 
end
as 'Industry Sub-category'
      ,bc.[Topic ID]
      ,bc.[Topic Name]
      ,bc.[Composite Score]
      ,bc.[Shoretel ID]
      ,bc.[Date]
      ,bc.[Topic_Competitor_name]
--bc.* 
,cust.STTerritory,cust.[Region]
from 
 Bombora_Comprehensive_Report bc 
 inner join [dbo].[SFDC_CUSTOMERS] cust
on cast(bc.[Shoretel ID]  as varchar)= cust.ImpactNumber


