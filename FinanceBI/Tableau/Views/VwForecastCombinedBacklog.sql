










/****** Script for SelectTopNRows command from SSMS  ******/
 

CREATE view [Tableau].[VwForecastCombinedBacklog]   as
--MW  03122019  Combined view for tabby

select * from tableau.mVwForecastCombinedBacklog

--SELECT    -- top 1
--		'Boss' + Region as Source,
--		CASE WHEN Region = 'US' then 'NA' ELSE Region End as Region, 
--		[Platform], 
--		MonthlyCharge, 
--		ForecastDate, 
--		OrderStatus, 
--		--MasterOrderType, 
--		BillingStage, 
--		ServiceStatus,
--		null as StallReason

--FROM            
--	tableau.VwBacklog_Connect
 

--UNION ALL
--select-- top 1  
--		'CostguardUS' as Source,
--		'NA' as Region,
--		[Platform], 
--		MonthlyCharge, 
--		ForecastDate, 
--		OrderStatus, 
--		--MasterOrderType, 
--		BillingStage, 
--		'' as ServiceStatus,
--		StallReason
--FROM
--		Costguard.CostGuardBI.tableau.VwFBOBacklog_export













