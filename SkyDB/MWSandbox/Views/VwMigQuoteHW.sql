CREATE VIEW [MWSandbox].[VwMigQuoteHW]
AS
-- MW 02012018  Mapped to Connect from HW data from Elvis
SELECT aa.AccountId
	,aa.AccountName
	,l.[Name] AS LocationName
	,l.[Address] + ', ' + l.Address2 + ', ' + l.City + ', ' + l.ZipCode AS Address
	,b.ProductId -- ConnectMapping
	,e.[Prod Name] AS ProductName
	,count(*) AS Qty
FROM (
	SELECT [tn]
		,[device]
	FROM [app_skydb].[SkyCSData]
	WHERE isnumeric(device) = 1
	
	UNION ALL
	
	SELECT [tn]
		,[device]
	FROM [app_skydb].[SkySipData]
	WHERE isnumeric(device) = 1
	) a
INNER JOIN MWSandbox.ElvisHWMap b ON a.device = b.Id
INNER JOIN [$(FinanceBI)].provision.Tn t ON a.tn = t.Id
	AND isnumeric(t.AccountId) = 1
INNER JOIN [$(FinanceBI)].[company].[Location] l ON t.LocationId = l.Id
INNER JOIN MWSandbox.MigrationCustList aa ON t.AccountId = aa.AccountId
INNER JOIN [$(FinanceBI)].[enum].[VwProduct] e ON b.ProductId = e.[Prod Id]
GROUP BY aa.AccountId
	,aa.AccountName
	,t.LocationId
	,l.[Name]
	,l.[Address] + ', ' + l.Address2 + ', ' + l.City + ', ' + l.ZipCode
	,b.ProductId -- ConnectMapping
	,e.[Prod Name]