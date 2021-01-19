
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Nov 28, 2014
-- Description:	Monthly Vendor Cost at Component Level by Account 
-- =============================================
CREATE FUNCTION [rollup].[UfnCostByAccount] 
(	
	@GivenMonth  Date -- Given Month
)
RETURNS TABLE 
AS
RETURN 
(
	select --top 10
	A.Id AccountId, A.Name Client, 
	SUM(case WHEN DP.Category = 'Access Services' THEN 
		cast(LD.cost as float) + cast(LD.cost_usage as float)
			else 0 END)  [Access Services Cost], 
	SUM(case WHEN DP.Category = 'Telephone Number' THEN 
		cast(LD.cost as float) + cast(LD.cost_usage as float)
			else 0 END)  [TN Cost], 
	SUM(case WHEN DP.Category = 'Usage' THEN 
		cast(LD.cost as float) + cast(LD.cost_usage as float)
			else 0 END)  [Usage Cost],
	SUM(case WHEN DP.Id is null or DP.Category not in ('Usage', 'Access Services','Telephone Number') THEN 
		cast(LD.cost as float) + cast(LD.cost_usage as float)
			else 0 END)  [Other Cost],
	 count(1) [Count]
	 from vendor.DLabs_GPMLineDetails LD
	left join Vendor.DLabs_Products DP on DP.Id = LD.product_id
	inner join company.Account A on A.Id = LD.client_id
	where 
	dbo.UfnFirstOfMonth(LD.bill_date) = @GivenMonth
	group by A.Id , A.Name 
)
