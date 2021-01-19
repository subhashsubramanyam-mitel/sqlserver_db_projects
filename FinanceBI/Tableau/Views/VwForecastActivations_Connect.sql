








CREATE View [Tableau].[VwForecastActivations_Connect] as
-- MW 02052019 Connect feed for  Combined view

	SELECT    
	 'US' AS Region
	,DateSvcLiveScheduled as ForecastDate
	,DateSvcLiveActual
	,[OneTimeCharge]
	,[MonthlyCharge]
	,'UCaaS' as Platform
	,CASE WHEN SvcPlatform = 'Call Conductor' Then 'SKY' else 'Connect' End as ActivationType
	,o.OrderId as OrderNumber
	,a.Name as AccountName
	,p.FirstName +' '+ p.LastName as Coordinator
	,'' as StalledReason

 FROM oss.VwServiceProduct_EX
 LEFT JOIN [company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
 LEFT Join oss.VwOrder O on oss.VwServiceProduct_EX.OrderId = O.OrderId 
Left join enum.OrderType ot on o.OrderTypeId =  ot.Id
left join company.Account a on O.AccountId = a.Id
left join people.person p on O.ProjectManagerId = p.Id
left join oss.VwOrderItemDetail_EX oi on o.OrderId = oi.OrderId   AND
 										 VwServiceProduct_EX.ServiceId = oi.ServiceId
where  
	IsBillable = 1 and
	ot.Name in ('Add (not linked)', 'Linked Add', 'Initial') and
	BillingStage <> 'Voided'  and
	isnull(O.MasterOrderTypeId,100)  <> 6 -- no Migrations select * from enum.OrderType
UNION ALL

	SELECT    
	 'AU' AS Region
	,DateSvcLiveScheduled as ForecastDate
	,DateSvcLiveActual
	,[OneTimeCharge]
	,[MonthlyCharge]
	,'UCaaS' as Platform
	,  'Connect'   as ActivationType
	,o.OrderId as OrderNumber
	,a.Name as AccountName
	,p.FirstName +' '+ p.LastName as Coordinator
	,'' as StalledReason
 FROM AU_FinanceBI.oss.VwServiceProduct_EX
 LEFT JOIN AU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
 LEFT Join AU_FinanceBI.oss.VwOrder O on  VwServiceProduct_EX.OrderId = O.OrderId 
 LEFT Join AU_FinanceBI.oss.[VwOrder] O2 on  O.MasterOrderId = O2.OrderId 
Left join AU_FinanceBI.enum.OrderType ot on o.OrderTypeId =  ot.Id
left join company.Account a on O.AccountId = a.Id
left join people.person p on O.ProjectManagerId = p.Id
left join AU_FinanceBI.oss.VwOrderItemDetail_EX oi on o.OrderId = oi.OrderId   AND
 										 VwServiceProduct_EX.ServiceId = oi.ServiceId
where  
	--IsBillable = 1 and note used intl ?
	ot.Name in ('Add (not linked)', 'Linked Add', 'Initial') and
	BillingStage <> 'Voided' and
	isnull(O2.OrderTypeId,100)  <> 6
UNION ALL

	SELECT    
	 'UK' AS Region
	,DateSvcLiveScheduled as ForecastDate
	,DateSvcLiveActual
	,[OneTimeCharge]
	,[MonthlyCharge]
	,'UCaaS' as Platform
	,  'Connect'   as ActivationType
	,o.OrderId as OrderNumber
	,a.Name as AccountName
	,p.FirstName +' '+ p.LastName as Coordinator
	,'' as StalledReason
 FROM EU_FinanceBI.oss.VwServiceProduct_EX
 LEFT JOIN EU_FinanceBI.[company].[VwAccount] ON VwServiceProduct_EX.[AccountId] = [VwAccount].[Ac Id]
 LEFT Join EU_FinanceBI.oss.VwOrder O on         VwServiceProduct_EX.OrderId = O.OrderId 
 LEFT Join EU_FinanceBI.oss.[VwOrder] O2 on  O.MasterOrderId = O2.OrderId 
Left join EU_FinanceBI.enum.OrderType ot on o.OrderTypeId =  ot.Id
left join company.Account a on O.AccountId = a.Id
left join people.person p on O.ProjectManagerId = p.Id
left join EU_FinanceBI.oss.VwOrderItemDetail_EX oi on o.OrderId = oi.OrderId   AND
 										 VwServiceProduct_EX.ServiceId = oi.ServiceId
where  
	IsBillable = 1 and --note used intl ?
	ot.Name in ('Add (not linked)', 'Linked Add', 'Initial') and
	BillingStage <> 'Voided' and
	isnull(O2.OrderTypeId,100)  <> 6






