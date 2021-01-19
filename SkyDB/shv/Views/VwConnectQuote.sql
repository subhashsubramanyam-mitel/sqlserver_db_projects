CREATE VIEW [shv].[VwConnectQuote]
AS
--MW 03162018 AHV Migration quote
SELECT a.AccountId
	,a.AccountName
	,a.LocationId
	,a.LocationName
	,p.[Name] AS ProductName
	,p.ProdCategory
	,sum(a.Charge) AS Total
	,sum(a.Quantity) AS Qty
FROM
	--shv.CustomerServices a inner join
	shv.VwCustomerServiceDetail a
INNER JOIN shv.ConnectProductMap b ON a.ProductId = b.SHVProductId
INNER JOIN [$(FinanceBI)].enum.Product p ON b.ConnectProductId = p.Id
GROUP BY a.AccountId
	,a.AccountName
	,a.LocationId
	,a.LocationName
	,p.[Name]
	,p.ProdCategory

UNION ALL

-- MW 03262018  Add Phones from Spreadsheet.
SELECT 'AU' + convert(VARCHAR(25), [Account ID]) AS AccountId
	,a.[Name]
	,'AU' + convert(VARCHAR(25), [Account ID]) AS LocationId
	,a.[Name] AS LocationName
	,p.[Name] AS ProductName
	,p.ProdCategory
	,NULL AS Charge
	,sum([Qty]) AS Qty
FROM [shv].[CustomerPhones] a
INNER JOIN [$(FinanceBI)].enum.Product p ON ConnectProduct = p.Id
WHERE isnumeric([Account Id]) = 1
GROUP BY [Account ID]
	,a.[Name]
	,p.[Name]
	,p.ProdCategory