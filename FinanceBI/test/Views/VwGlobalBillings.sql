
CREATE view [test].[VwGlobalBillings] as
-- MW 03132018 MW test view for tableau
SELECT

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'UK' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,'EU-' +Convert(Char(15), InvoiceGroupId) as InvoiceGroupId


FROM [EU_FinanceBI].[invoice].[VwLineItem]

LEFT JOIN [EU_FinanceBI].[company].[VwAccount]
ON [VwLineItem].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [EU_FinanceBI].[enum].[VwProduct]
ON [VwLineItem].[ProductId] = [VwProduct].[Prod Id]

UNION ALL

SELECT

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'AU' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,'AU-' +Convert(Char(15), InvoiceGroupId) as InvoiceGroupId


FROM [AU_FinanceBI].[invoice].[VwLineItem]

LEFT JOIN [AU_FinanceBI].[company].[VwAccount]
ON [VwLineItem].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [AU_FinanceBI].[enum].[VwProduct]
ON [VwLineItem].[ProductId] = [VwProduct].[Prod Id]

Union All

SELECT  

-- ACCOUNT INFO: [company].[VwAccount]
	 [Ac Id]
	,[Ac Name]
	,[LichenAccountId]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[AccountManagerId]
	,'US' AS Region

-- INVOICE INFO: [invoice].[VwLineItem]
	,[LineItemId]
	,[InvoiceId]
	,[DateGenerated]
	,[LocationId]
	,[Charge]
	,[ChargeCategory]
	,[OneTimeCharge]
	,[MonthlyCharge]
	,[Prorates]
	,[MRR]
	,[Usage]
	,[Credits]
	,[Regulatory]
	,[Surcharge]
	,[Unclassified]
	,[Tax]
	,[Quantity]

-- PRODUCT INFO: [enum].[VwProduct]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Prod Id]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,Convert(Char(15), InvoiceGroupId) as InvoiceGroupId


FROM [invoice].[VwLineItem]

LEFT JOIN [company].[VwAccount]
ON [VwLineItem].[AccountId] = [VwAccount].[Ac Id]

LEFT JOIN [enum].[VwProduct]
ON [VwLineItem].[ProductId] = [VwProduct].[Prod Id]
where year([invoice].[VwLineItem].[DateGenerated]) >=2016
