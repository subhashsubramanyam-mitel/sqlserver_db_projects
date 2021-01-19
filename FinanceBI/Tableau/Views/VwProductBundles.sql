


CREATE view [Tableau].[VwProductBundles] as
--MW 07182019 Show bundles
select
	 a.ProductBundleId 
	,a.ProductBundleName 
	,a.ProductId as ComponentId
	,a.ProductName ComponentName
	,b.DefaultMonthlyCharge as BundleMonthlyCharge
	,a.[Percentage] as ComponentPercent
	,b.MRR_SKU 	as Bundle_MRR_SKU
	,b.NRR_SKU	as Bundle_NRR_SKU
	,bb.MRR_SKU 	as Component_MRR_SKU
	,bb.NRR_SKU	as Component_NRR_SKU
FROM
(
SELECT PCT.ProductBundleId AS ProductBundleId ,
       PR1.Name            AS ProductBundleName ,
       PCT.ProductId       AS ProductId , 
       PR2.Name            AS ProductName ,
       PCT.AxPercentage    AS [Percentage] 
FROM M5DB.m5db.dbo.billing_AxBundleProductPercents PCT
    INNER JOIN M5DB.m5db.dbo.billing_Product PR1
        ON  PCT.ProductBundleId = PR1.Id
    INNER JOIN M5DB.m5db.dbo.billing_Product PR2
        ON PCT.ProductId = PR2.Id
 
) a inner join
		enum.VwProduct b on a.ProductBundleId = b.[Prod Id] inner join
		enum.VwProduct bb on a.ProductId = bb.[Prod Id] 
