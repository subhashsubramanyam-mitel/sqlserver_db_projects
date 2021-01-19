
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 28, 2014
-- Description:	Monthly Vendor Cost at High Level 
-- =============================================
Create FUNCTION rollup.UfnHighLevelCost 
(	
	@GivenMonth  Date -- Given Month
)
RETURNS TABLE 
AS
RETURN 
(
	select --top 10
	HCC.CostCategory, HCC.PrefixPattern, coalesce(HCC.Id, 19) HCCId, SUM(cast(LD.cost as float)) cost, 
	SUM(cast(LD.cost_usage as float) ) usage, count(1) count
	 from vendor.DLabs_GPMLineDetails LD
	left join Vendor.DLabs_Products DP on DP.Id = LD.product_id
	left join enum.VendorHLCostCategory HCC on  DP.name like HCC.PrefixPattern 
	where 
	dbo.UfnFirstOfMonth(LD.bill_date) = @GivenMonth
	group by HCC.CostCategory,  HCC.PrefixPattern, coalesce(HCC.Id, 19) 
)
