






CREATE view [MWSandbox].[VwMigQuoteProfiles] as
-- MW 11292017 Profile Product Quote
select
    
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,  ConnectProductId
 , ProductName
 ,SUM(Qty) as QTY
  ,SUM(a.MRR) as MRR
  ,SUM(ConnectListMRR) as ConnectListMRR
 from
(
 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,ConnectProductNoApps  as ConnectProductId
 ,p.Name as ProductName
 ,Count(*) as Qty
 ,SUM(a.MRR) as MRR
 ,SUM(isnull(pp.ConnectListMRR,0)) as ConnectListMRR 
 from
 MWSandBox.VwSkyCustomerServiceMig a left outer join
MWsandbox.VwAppsByTN c on a.AccountId = c.AccountId AND a.TN=c.TN   left outer join
[$(FinanceBI)].enum.Product p on  ConnectProductNoApps  
						= p.Id left outer join
MWSandbox.ConnectPricing pp on ConnectProductNoApps = pp.ProductId
where  --a.AccountId = 109 and 
a.Category  = 'Profiles' and c.Apps is null
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,p.Name
 ,ConnectProductNoApps  
 UNION ALL  -- MW there really is no need for this
  select  
 a.AccountId,
 a.AccountName 
 ,a.LocationName
 ,a.Address
 ,  a.ConnectProductApps  AS ConnectProductId
 ,p.Name as ProductName
 ,Count(*) as Qty
  ,SUM(a.MRR) as MRR
   ,SUM(isnull(pp.ConnectListMRR,0)) as ConnectListMRR 
 from
 MWSandBox.VwSkyCustomerServiceMig a inner join
MWsandbox.VwAppsByTN c on a.AccountId = c.AccountId AND a.TN=c.TN   left outer join
[$(FinanceBI)].enum.Product p on  a.ConnectProductApps  
						= p.Id  left outer join
MWSandbox.ConnectPricing pp on ConnectProductApps = pp.ProductId
where  --a.AccountId = 109 and 
a.Category  = 'Profiles'   
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,p.Name
 , a.ConnectProductApps  
 ) a
 group by 
  a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,  ConnectProductId
 , ProductName
 





