CREATE VIEW [MWSandbox].[VwNumRentalPhones]
AS
-- MW 12042017 num phones for cust list
SELECT aa.AccountId
	,count(*) AS NumRentalPhones
FROM [$(FinanceBI)].[oss].[VwServiceProduct_EX] a
INNER JOIN dbo.MigrationCustList1130 aa ON a.AccountId = aa.AccountId
LEFT OUTER JOIN [$(FinanceBI)].enum.ServiceStatus b ON a.ServiceStatusId = b.Id
LEFT OUTER JOIN [$(FinanceBI)].enum.VwProduct e ON a.ProductId = e.[Prod Id] -- inner join
	--Only migration Products
	--MWSandbox.MigrationMap f on a.ProductId = f.SkyProductId
WHERE b.Name = 'Active'
	AND e.[Class Group] = 'Rental Phones'
GROUP BY aa.AccountId