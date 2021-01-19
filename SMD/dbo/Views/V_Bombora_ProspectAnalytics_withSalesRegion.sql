



CREATE  VIEW [dbo].[V_Bombora_ProspectAnalytics_withSalesRegion]
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
--      ,bc.[Shoretel ID]
      ,bc.[Date]
      --,bc.[Topic_Competitor_name]
,bc.[Zip Code]
,ter.TerritoryName  as STTerritory,
ter.[Region]
,ter.[ASM]
,ter.[CloudCSR]
from 
 [dbo].[Bombora_Prospect_Comprehensive_Report] bc 
inner   join V_ZIPTOTERRITORY ter --[dbo].[SFDC_CUSTOMERS] cust
on cast(bc.[Zip Code]   as varchar) = ter.Zipcode
--left outer join [dbo].[SFDC_TERRITORY] ter on ter.[Region] = cust.Region 
/* orig
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
--      ,bc.[Shoretel ID]
      ,bc.[Date]
      --,bc.[Topic_Competitor_name]
,bc.[Zip Code]
,cust.STTerritory,cust.[Region]
,ter.[ASM]
,ter.[CloudCSR]
from 
 [dbo].[Bombora_Prospect_Comprehensive_Report] bc 
left outer join [dbo].[SFDC_CUSTOMERS] cust
on 
cast(bc.[Zip Code]   as varchar) = cust.Zipcode
left outer join [dbo].[SFDC_TERRITORY] ter
on ter.[Region] = cust.Region
--= cust.ImpactNumber
*/


--GO



