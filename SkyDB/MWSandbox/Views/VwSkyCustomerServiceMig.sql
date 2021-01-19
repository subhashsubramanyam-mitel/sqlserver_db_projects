







CREATE View [MWSandbox].[VwSkyCustomerServiceMig] as
--MW 11292017 Active Sky Services WITH MIGRATION MAP
SELECT 
	aa.AccountId,
	aa.AccountName,
	c.[Name] as LocationName,
	c.Address + ', '+	c.Address2 + ', '+ c.City + ', '+	c.ZipCode as Address,
	e.[Prod Id] as ProductId,
	e.[Prod Name] as ProductName,
	e.[Prod Category] as Category,
	f.ConnectProductNoApps,
	f.ConnectProductApps,
	--MW 08202020  Filter + from TN and pull direct from ServiceProduct
	CASE WHEN  len(replace(replace(replace(a.TN,'+',''), CHAR(13), ''), CHAR(10), '')) = 11 then 
		substring(replace(replace(replace(a.TN,'+',''), CHAR(13), ''), CHAR(10), ''), 2,11) else  
		replace(replace(replace(a.TN,'+',''), CHAR(13), ''), CHAR(10), '') end as TN,
	a.MonthlyCharge as MRR,
	CASE WHEN e.[Class Group]  = 'Rental Phones'  AND a.MonthlyCharge = 0 Then 1 else 0 End AS isFreePhone
	--,a.TN as x
  FROM 
	--[$(FinanceBI)].[oss].[VwServiceProduct_EX] a inner join
	[$(FinanceBI)].[oss].[ServiceProduct] a inner join
	MWSandbox.QuoteProducts p on a.ProductId = p.ProductId inner join
	MWSandbox.MigrationCustList aa on a.AccountId = aa.AccountId left outer join
	[$(FinanceBI)].enum.ServiceStatus b on a.ServiceStatusId = b.Id left outer join 
	[$(FinanceBI)].company.Location c on a.LocationId = c.[Id] left outer join
	[$(FinanceBI)].enum.VwProduct e on a.ProductId = e.[Prod Id]  inner join
	--Only migration Products
	 MWSandbox.MigrationMap f on a.ProductId = f.SkyProductId inner join
	 MWSandBox.ServicesBilledLastMonth bil on a.ServiceId = bil.ServiceId  and a.ProductId = bil.ProductId-- only billed last month
	--	where b.Name = 'Active'  and
		--and aa.BatchNumber = '1'
				 -- MW 20180405  services can have several products
		-- a.MonthMRRLastInvoiced  = [$(FinanceBI)].dbo.UfnFirstOfMonth(getdate());
 


