




CREATE view [rollup].[VwAccountStats]
as 
select S.*, 
	ProfileRevenue+ProfileCost ProfileProfit,
	AccessRevenue+AccessCost AccessProfit,
	TotalRevenue+ContributionCost ContributionProfit,
	TotalRevenue+GrossCost GrossProfit

from rollup.AccountStats S




