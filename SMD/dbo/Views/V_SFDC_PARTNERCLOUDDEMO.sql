



 CREATE view [dbo].[V_SFDC_PARTNERCLOUDDEMO] as
-- MW 12142016 View to populate scorecard attrib PartnerCloudDemoProfiles IN SFDC
-- MW 05012017 updating to account for internal accounts


select ImpactNumber, SUM(Quantity) AS Quantity from
(
select  
c.ImpactNumber, 
Sum(isnull
	(LI.Quantity,0)) Quantity
from 
		   SFDC_CUSTOMERS c inner join
		   SVLBIDB.FinanceBi.invoice.VwLineItem_EX LI on c.M5DBAccountID = LI.AccountId
inner  join SVLBIDB.FinanceBi.enum.Product P on P.Id = LI.ProductId 
where
c.Type = 'Partner'
and isnumeric(c.M5DBAccountID) = 1 
and LI.DateGenerated > = DATEADD(month, DATEDIFF(month, 0, getdate()), 0)  --between '2016-12-01' and '2016-12-31' 
and P.ProdCategory = 'Profiles'
and LI.ChargeCategory = 'MRR'
group by 
c.ImpactNumber
 
UNION ALL

-- Internal use
select b.ImpactNumber, 
Sum(isnull
	(LI.Quantity,0)) Quantity

from 
SFDC_CUSTOMERS a inner join
SFDC_CUSTOMERS b on a.PartnerOfRecordCloud =b.SfdcId  inner join
		   SVLBIDB.FinanceBi.invoice.VwLineItem_EX LI on a.M5DBAccountID = LI.AccountId
inner  join SVLBIDB.FinanceBi.enum.Product P on P.Id = LI.ProductId 
where 
(a.NAME LIKE '%Internal%' OR a.NAME LIKE  '%Demo%') and
b.Type = 'Partner'
and isnumeric(a.M5DBAccountID) = 1 
and LI.DateGenerated > = DATEADD(month, DATEDIFF(month, 0, getdate()), 0)  --between '2016-12-01' and '2016-12-31' 
and P.ProdCategory = 'Profiles'
and LI.ChargeCategory = 'MRR'
group by 
b.ImpactNumber
 ) a
 group by ImpactNumber


  

