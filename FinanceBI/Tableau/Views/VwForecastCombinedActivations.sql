




/****** Script for SelectTopNRows command from SSMS  ******/




CREATE view [Tableau].[VwForecastCombinedActivations] as
--MW 02042019 Combining FBO and COnnect for global unified forecast
SELECT      
		'Boss' + Region as Source,
		CASE WHEN Region = 'US' then 'NA' ELSE Region End as Region, 
		ForecastDate, 
		DateSvcLiveActual as [Live Date], 


		MonthlyCharge as MRR, 
		--MonthlyCharge_LC,
		--OneTimeCharge_LC, 
		OneTimeCharge as NRR,
		Platform,
		ActivationType as CustomerTypeService,
		ActivationType as CustomerTypeOrder,
		ActivationType as ActivationType
	,OrderNumber
	,AccountName
	,Coordinator
	,StalledReason
FROM            
	tableau.VwForecastActivations_Connect
 

UNION ALL
select 
	'CostguardUS' as Source,
	'NA' as Region,
	[Forecast Date],  
	[Live Date], 
	MRR,
	NRR,
	Case when [Activation Type] IN ('MiCloud Engage', 'MiCloud Flex', 'MiCLoud Other', 'Network Services', 'UnSpecified') then 'UC' ELSE 'UCaaS' END as Platform,
	[Customer Category for Service], 
	[Order Customer Category],
	[Activation Type]
	,OrderNumber
	,AccountName
	,Coordinator
	,StalledReason
FROM
		Costguard.CostGuardBI.tableau.VwFBOActivations_export







