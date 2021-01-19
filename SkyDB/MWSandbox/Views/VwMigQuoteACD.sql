
  CREATE view [MWSandbox].[VwMigQuoteACD] as
 -- MW 02202018 ACD Quote



 select  
 a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 , a.ConnectProductNoApps  AS ConnectProductId
 -- show free rental phones as separate line
 -- MW 02012018  not needed anymore
 , p.Name   as ProductName
 ,Count(*) as Qty
  ,SUM( p.DefaultMonthlyCharge   ) as MRR
 from
 MWSandBox.VwSkyCustomerServiceMig a  inner join
 [$(FinanceBI)].enum.Product p on a.ConnectProductNoApps 
		    			     = p.Id
where  --a.AccountId = 13763   
 --and a.ProductName NOT LIKE '%ACD%'
 -- ACD
   a.ProductId   IN
				 (
				24,
				25,
				125,
				179,
				274,
				275
				) 
Group BY 
a.AccountId,
 a.AccountName
 ,a.LocationName 
 ,a.Address
 ,a.ConnectProductNoApps  
 , p.Name  



  


