





CREATE view [Tableau].[VwCombinedBacklog] as 
-- MW 11062019  For evodio, merge unconfirmed contracts and pipeline

select   * from (


select
	 'Pipeline' as Source
	,OpportunityNumber
	,OppCloseDate
	,Platform
	,null as ProductFromBlue
	,convert( float, MonthlyCharge) as MRR
	,convert( int, SeatCount) as Seats
	,null as ContractStatus
	,Region
	,BillingStage
	,VoidDate
	,DateSvcLiveActual 
	,[Ac Name]
	,ProjectOwnerName as PMName
	,ForecastDate
	,OrderType
	,MasterOrderType
	,Case 
		When BillingStage = 'Voided' THEN 'VOIDED'
		When BillingStage <> 'Voided' AND DateSvcLiveActual = [VoidDate] then 'VOIDED'
		When BillingStage = 'Billing' AND  DateSvcLiveActual is null then 'VOIDED'
		When BillingStage   <> 'Voided' AND DateSvcLiveActual < [VoidDate] then 'ACTIVATED'
		When BillingStage   <> 'Voided' AND    [VoidDate] is not null then 'VOIDED'
		When BillingStage <> 'Voided' AND   [VoidDate] is null AND   DateSvcLiveActual is not null then 'ACTIVATED'
		When BillingStage <> 'Voided' AND  [VoidDate] is null AND  DateSvcLiveActual is null AND ForecastDate is null then 'UNFORECASTED'
		When BillingStage <> 'Voided' AND  [VoidDate] is null AND  DateSvcLiveActual is null AND ForecastDate < getdate() then 'PAST DUE'
		ELSE   'FORECASTED'
	 END AS BacklogStatus
	 ,OrderDate
	 ,[Order PM] as OrderPM_Boss
FROM
 tableau.VwGlobalPipeline
where ServiceStatus in ('Pending', 'Provisioning')
-- MW 01092020 Evo wants last 120 days of activations
UNION ALL
select
	 'Activations' as Source
	,OpportunityNumber
	,OppCloseDate
	,Platform
	,null as ProductFromBlue
	,convert( float, MonthlyCharge) as MRR
	,convert( int, SeatCount) as Seats
	,null as ContractStatus
	,Region
	,BillingStage
	,VoidDate
	,DateSvcLiveActual 
	,[Ac Name]
	,ProjectOwnerName as PMName
	,ForecastDate
	,OrderType
	,MasterOrderType
	,Case 
		When BillingStage = 'Voided' THEN 'VOIDED'
		When BillingStage <> 'Voided' AND DateSvcLiveActual = [VoidDate] then 'VOIDED'
		When BillingStage = 'Billing' AND  DateSvcLiveActual is null then 'VOIDED'
		When BillingStage   <> 'Voided' AND DateSvcLiveActual < [VoidDate] then 'ACTIVATED'
		When BillingStage   <> 'Voided' AND    [VoidDate] is not null then 'VOIDED'
		When BillingStage <> 'Voided' AND   [VoidDate] is null AND   DateSvcLiveActual is not null then 'ACTIVATED'
		When BillingStage <> 'Voided' AND  [VoidDate] is null AND  DateSvcLiveActual is null AND ForecastDate is null then 'UNFORECASTED'
		When BillingStage <> 'Voided' AND  [VoidDate] is null AND  DateSvcLiveActual is null AND ForecastDate < getdate() then 'PAST DUE'
		ELSE   'FORECASTED'
	 END AS BacklogStatus
	 ,OrderDate
	 ,[Order PM] as OrderPM_Boss
FROM
 tableau.VwGlobalPipeline
where DateSvcLiveActual > getdate()-120
--
UNION ALL
select
	 'Unconfirmed Contracts' as Source
	,OpportunityNumber collate database_default 
	,CloseDate
	,Platform collate database_default
	,ProductFromBlue collate database_default
	,convert( float, MRR) as MRR
	,convert( int, replace( CloudProfiles,'.0',''))  as Seats 
	--,CASE WHEN ISNUMERIC(CloudProfiles) = 1 THEN CAST(CloudProfiles AS INT) ELSE NULL END as Seats
	,ContractStatus collate database_default
	,OpportunityRegion  collate database_default as Region
	,'Unconfirmed Contracts' collate database_default  as BillingStage
	,null as VoidDate
	,null as DateSvcLiveActual
	,AccountName collate database_default  as AccountName
	,TaskfeedPM  collate database_default 
	,null as ForecastDate
	,'Initial' as OrderType
	,CASE WHEN SubType= 'Migrate Call Conductor to MiCloud Connect' then 'Migration' else null end as MasterOrderType
	,'Pending Contract Confirmation' as BacklogStatus
	,OrderDate
	,TaskfeedPM  collate database_default as OrderPM_Boss
  FROM [Tableau].[VwForcast_OrderToOpp]
where   RecordType in ( 'Standard' , 'Cloud Account Management' ) 
and ForecastCategory_Report  = 'Won - Pending BOSS Entry'
and SubType <> 'Correction to Initial Contract'
--and CloudProfiles is not null
	and OpportunityNumber collate database_default  in
	(select ContractNumber from sales.Contract where ContractStatusId = 2)
and OpportunityNumber NOT IN
	(
	'1248395',
	'1238101',
	'1283417',
	'1324538'
	)
) a 
