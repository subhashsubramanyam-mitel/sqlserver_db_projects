






 CREATE view [MWSandbox].[VwMigQuoteOther] as
 -- MW 11292017 non Profile Product Quote

   select  
  AccountId,
  AccountName
 , LocationName 
 , Address
 , ConnectProductId
 , ProductName
 , SUM(Qty) as Qty
  , SUM(MRR) as MRR
  FROM (
 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 , a.ConnectProductNoApps  AS ConnectProductId
 -- show free rental phones as separate line
 -- MW 02012018  not needed anymore
 ,CASE WHEN a.isFreePhone =1 then p.Name + ' -Free Rental' ELSE p.Name END as ProductName
 ,Count(*) as Qty
  ,SUM(CASE WHEN a.isFreePhone =1 then 0 ELSE p.DefaultMonthlyCharge END ) as MRR
 from
 MWSandBox.VwSkyCustomerServiceMig a  inner join
 [$(FinanceBI)].enum.Product p on a.ConnectProductNoApps 
		    			     = p.Id
where  --a.AccountId = 13894 and 
a.Category  <> 'Profiles' and -- a.Category not like '%Hardware%' and
--
  a.ConnectProductNoApps NOT IN  
( -- these are in Chris's data
287,
325,
326,
336,
370,
391
) and
--
a.TN is null and-- not in bundle
  a.ProductName NOT LIKE '%ACD%'
 and a.ProductId NOT IN
 (
233,
235,
11,
10,
9,
59,
111
) 
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,a.ConnectProductNoApps  
 ,CASE WHEN a.isFreePhone =1 then p.Name + ' -Free Rental' ELSE p.Name END
 --
UNION ALL
-- MW 04182018 special case for FAX or other services tied to a profile
--  Add products to the include list
 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 , a.ConnectProductNoApps  AS ConnectProductId
 -- show free rental phones as separate line
 -- MW 02012018  not needed anymore
 ,CASE WHEN a.isFreePhone =1 then p.Name + ' -Free Rental' ELSE p.Name END as ProductName
 ,Count(*) as Qty
  ,SUM(CASE WHEN a.isFreePhone =1 then 0 ELSE p.DefaultMonthlyCharge END ) as MRR
 from
 MWSandBox.VwSkyCustomerServiceMig a  inner join
 [$(FinanceBI)].enum.Product p on a.ConnectProductNoApps 
		    			     = p.Id
where  --a.AccountId = 13894 and 
a.Category  <> 'Profiles' and -- a.Category not like '%Hardware%' and
a.TN is not null 
 and a.ProductId   IN
 (
359,
18
) 
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,a.ConnectProductNoApps  
 ,CASE WHEN a.isFreePhone =1 then p.Name + ' -Free Rental' ELSE p.Name END

 UNION ALL
 -- MW 02012018 Mobility Special CASE
 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 , a.ConnectProductNoApps  AS ConnectProductId
 ,p.Name  as ProductName
 ,Count(*) as Qty
  ,SUM(CASE WHEN a.isFreePhone =1 then 0 ELSE p.DefaultMonthlyCharge END ) as MRR
 from
 MWSandBox.VwSkyCustomerServiceMig a  inner join
 [$(FinanceBI)].enum.Product p on a.ConnectProductNoApps 
		    			     = p.Id
where  
   a.ProductId  in (299,255)
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,a.ConnectProductNoApps  
 ,p.Name  
 
	 ) a
 group by 
   AccountId,
  AccountName
 , LocationName 
 , Address
 , ConnectProductId
 , ProductName


 /*   -- No ACD in first batch  MW 02012018
      -- Needs to use Elvis data
 UNION ALL
 -- count all ACD items 
 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 , a.ConnectProductNoApps  AS ConnectProductId
 ,p.Name as ProductName
 ,Count(*) as Qty
  ,SUM(p.DefaultMonthlyCharge) as MRR
 from
 MWSandBox.VwSkyCustomerServiceMig a  inner join
[$(FinanceBI)].enum.Product p on a.ConnectProductNoApps 
		    			     = p.Id
where --a.AccountId = 109 and 
a.Category  <> 'Profiles'  
 and a.ProductName   LIKE '%ACD%'
 and a.ProductId NOT IN
 (
233,
235,
11,
10,
9,
59,
111
) 
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,p.Name
 ,a.ConnectProductNoApps 

 */

 











