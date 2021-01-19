CREATE VIEW [enum].[VwProduct]
AS
SELECT P.ProdCategory [Prod Category]
	,P.ProdSubCategory
	,P.Name AS [Prod Name]
	,P.ShortName AS [Prod ShortName]
	,P.Id AS [Prod Id]
	,SC.DisplaySortOrder AS [Class Sort Order]
	,SC.nRootName AS [Class RootName]
	,SC.LichenClassName AS [Class Full Name]
	,SC.Name AS [Class Leaf Name]
	,P.ProdClassGroup AS [Class Group]
	,coalesce(P.PrimaryHandset, '') PrimaryHandset
	,RC.[Group] [Revenue Component]
	,P.IsCrossSellProduct
	,P.DefaultMonthlyCharge
	,P.DefaultOneTimeCharge
	,P.RevenueComponentId
	,P.MRR_SKU
	,P.NRR_SKU
FROM enum.Product P
LEFT OUTER JOIN enum.ServiceClass SC ON P.ServiceClassId = SC.Id
LEFT OUTER JOIN enum.PnLComponent RC ON RC.Id = P.RevenueComponentId








