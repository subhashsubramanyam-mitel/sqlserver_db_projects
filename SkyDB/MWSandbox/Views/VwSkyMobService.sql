
CREATE View [MWSandbox].[VwSkyMobService] as
--MW 01242018  Mobility
SELECT 
	a.AccountId
	,count(*) as Mobility
  FROM 
	[$(FinanceBI)].[oss].[VwServiceProduct_EX] a  inner join
	--MWSandbox.MigrationCustList aa on a.AccountId = aa.AccountId left outer join
	[$(FinanceBI)].enum.ServiceStatus b on a.ServiceStatusId = b.Id  
 
	--Only migration Products
	--MWSandbox.MigrationMap f on a.ProductId = f.SkyProductId
		 where b.Name = 'Active' and a.ProductId in (255,299)
		 group by a.AccountId
