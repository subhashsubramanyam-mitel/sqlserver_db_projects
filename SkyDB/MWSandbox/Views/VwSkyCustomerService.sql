

CREATE VIEW [MWSandbox].[VwSkyCustomerService]
AS
--MW 11292017 Active Sky Services
SELECT a.AccountId
	,aa.AccountName
	,a.LocationId
	,c.[Name] AS LocationName
	,c.Address + ', ' + c.Address2 + ', ' + c.City + ', ' + c.ZipCode AS Address
	,e.[Prod Id] AS ProductId
	,e.[Prod Name] AS ProductName
	,e.[Prod Category] AS Category
	,a.TN
	,a.MonthlyCharge_LC AS MRR
FROM [$(FinanceBI)].[oss].[VwServiceProduct_EX] a
INNER JOIN MWSandbox.QuoteProducts p ON a.ProductId = p.ProductId
INNER JOIN MWSandbox.MigrationCustList aa ON a.AccountId = aa.AccountId
LEFT OUTER JOIN [$(FinanceBI)].enum.ServiceStatus b ON a.ServiceStatusId = b.Id
LEFT OUTER JOIN [$(FinanceBI)].company.Location c ON a.LocationId = c.Id
LEFT OUTER JOIN [$(FinanceBI)].enum.VwProduct e ON a.ProductId = e.[Prod Id]
INNER JOIN MWSandBox.ServicesBilledLastMonth bil ON a.ServiceId = bil.ServiceId
	AND a.ProductId = bil.ProductId


	--Only migration Products
	--MWSandbox.MigrationMap f on a.ProductId = f.SkyProductId
		-- 
		--MW 09262018 joining with services billed last month will take care of these filters.
		 --where b.Name = 'Active' and 
		 -- MW 20180405  services can have several products
		 --a.MonthMRRLastInvoiced  = [$(FinanceBI)].dbo.UfnFirstOfMonth(getdate());


