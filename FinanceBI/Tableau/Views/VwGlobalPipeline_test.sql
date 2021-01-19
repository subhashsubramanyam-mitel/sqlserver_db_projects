











 
 CREATE view [Tableau].[VwGlobalPipeline_test] as 
 -- MW 07262019 segment region for speed
 -- select * into test.testPipe_US from [Tableau].[VwGlobalPipeline_US] 
 SELECT    
 
	 'US' AS Region
	,[Ac Name]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	-- per evodio MW 07182019
		,CASE WHEN VwServiceProduct_EX.ServiceId IN 
		(2350684,2350685,2350690,2350691,2350692,2366074) THEN 0 ELSE
	 [OneTimeCharge] END as OneTimeCharge
		,CASE WHEN VwServiceProduct_EX.ServiceId IN 
		(2350684,2350685,2350690,2350691,2350692,2366074) THEN 0 ELSE
	 [OneTimeCharge_LC] END AS OneTimeCharge_LC
	,[MonthlyCharge]
	,[MonthlyCharge_LC]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	,[Class RootName]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,DateSvcLiveScheduled as ForecastDate
	,DateSvcLiveActual
	,os.Name as OrderStatus
	,COALESCE(mig.OrderType, ot.Name) as OrderType
	,COALESCE(mig.MasterOrderType, otm.Name) as MasterOrderType
	-- Per Evo MW05292019
	,CASE WHEN (BillingStage = 'Closed' and DateSvcLiveActual is null) then 'Voided' ELSE BillingStage END as BillingStage
	,Cluster
	,pm.FirstName, pm.LastName
	,O.Id as OrderId
	,o.DateCreated as OrderDate
	,CASE WHEN 
		[enum].[VwProduct].[Prod Category] = 'Profiles' and 
		oi.OrderItemType = 'New Service' and
		enum.VwProduct.[Prod Name] <> 'MiCloud Connect IP Phone User' -- per Evo MW 07092019
				then oi.Quantity else 0 end as SeatCount
	,oi.DateBillingStart
 
	,VwServiceProduct_EX.ServiceId
	,VwServiceProduct_EX.DateSvcCreated
	,l.[Loc Name]
	,ss.Name as ServiceStatus
	,cb.FullName as OrderCreatedBy
	,VwServiceProduct_EX.[ProductId]
	,COALESCE(mig.PMName, pm.FirstName + ' ' +pm.LastName, cb.FirstName + ' ' +cb.LastName) as [Order PM]
	,str(datediff (day,  DateSvcCreated, getdate()))  as [AvgLife Days]
	-- MW 12062018  Adds for Kelly
	,opp.[Date Closed] as OppCloseDate
	,con.StartDate as ContractStartDate
	,con.DateCreated as ContractCreateDate
	,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate
	-- MW 05222019 Update logic per Evo
	,ISNULL( VwServiceProduct_EX.DateSvcVoided,
				CASE WHEN (VwServiceProduct_EX.BillingStage = 'Voided'  ) then VwServiceProduct_EX.DateSvcModified
				     WHEN (VwServiceProduct_EX.BillingStage = 'Closed'  and DateSvcLiveActual is null) then VwServiceProduct_EX.DateSvcModified
					ELSE NULL END
		  ) as VoidDate
	--MW 04082019 for Ben
	, [VwAccount].CCClusterName
	, [VwAccount].CCPlatformName
	-- PM Info MW 04152019
	--, convert(varchar(255), u.RoleName )  as SFDC_PM_Role
	, u.RoleName collate database_default as SFDC_PM_Role
	, pm.Id as PM_Id
	, isnull(con.ContractType, 'Other') as ContractType
		--MW 04082019 for Ben
	, [VwAccount].SMRClusterName
	, [VwAccount].SMRPlatformName
	, 'US' +'-' + convert(varchar(10),[VwAccount].[Ac Id]) as AccountId
	, pmr.BOSSPMRole
	, con.ContractProfileAmount
	, convert(varchar(10),opp.[# Profiles]) as OppProfileAmount
	, O.ContractNumber
	--
	,l.StateProvince as LocationState
	,VwServiceProduct_EX.SvcCluster as ServiceCluster

	,mpm.Master_PMName
	,mpm.Master_PMId
	,isnull(CASE WHEN tf.Type is null then tfm.TaskFeedProjectManager else tf.TaskFeedProjectManager end, p.ProjectOwnerName) as ProjectOwnerName
	,CASE 
			WHEN tf.Type is null and tfm.Type is null and  ss.Name <> 'Active' Then 'No Matching Taskfeed Board Found' 
			WHEN tf.Type is null and tfm.Type is null and ss.Name = 'Active' then p.DelayReason
			WHEN tf.Type is null and tfm.Type is not null  then tfm.DelayReason
			ELSE tf.DelayReason
	 end as ProjectDelayReason
	--,isnull(tf.DelayReasonDetails, p.DelayDescription) as ProjectDelayDescription
	,CASE WHEN tf.Type is null then tfm.DelayReasonDetails ELSE tf.DelayReasonDetails END as ProjectDelayDescription
	,VwServiceProduct_EX.MonthMRRLastInvoiced
	,VwServiceProduct_EX.LocationId
	, VwAccount.IsMCSSEnabled
	--Taskfeed
	,CASE WHEN tf.Type is null then tfm.TF_ProjectNumber end    collate database_default as TF_ProjectNumber
	,CASE WHEN tf.Type is null then tfm.TF_StartDate  end as TF_StartDate
	,CASE WHEN tf.Type is null then tfm.TF_EndDate  end as TF_EndDate
	,CASE WHEN tf.Type is null then tfm.TF_Stage end    collate database_default as TF_Stage
	,CASE WHEN tf.Type is null then tfm.TF_PctComplete  end as TF_PctComplete
	
	-- Formula from tableau into datasource for speed
		,Case 
			when BillingStage = 'Voided' THEN 'VOIDED'
			when  BillingStage not in ('Voided', 'Closed')  AND DateSvcLiveActual= VwServiceProduct_EX.DateSvcVoided then 'VOIDED'
			when  BillingStage = 'Billing' AND DateSvcLiveActual is null then 'VOIDED'
			when  BillingStage not in ('Voided', 'Closed')  AND DateSvcLiveActual< VwServiceProduct_EX.DateSvcVoided then 'ACTIVATED'
			when  BillingStage not in ('Voided', 'Closed')  AND (VwServiceProduct_EX.DateSvcVoided)  is not null then 'VOIDED'
			when  BillingStage not in ('Voided', 'Closed')  AND VwServiceProduct_EX.DateSvcVoided is null AND  DateSvcLiveActual is not null then 'ACTIVATED'
			when  BillingStage not in ('Voided', 'Closed')  AND VwServiceProduct_EX.DateSvcVoided is null AND DateSvcLiveActual is null AND DateSvcLiveScheduled is null then 'UNFORECASTED'
			when  BillingStage not in ('Voided', 'Closed')  AND VwServiceProduct_EX.DateSvcVoided is null AND DateSvcLiveActual is null AND DateSvcLiveScheduled < getdate() then 'PAST DUE'
		ELSE 'FORECASTED'
		END as DS_ActivationStatusRollup
	
	
	,st.*  --staffing fields

 
 FROM --oss.VwServiceProduct_EX
      -- MW 05212019  changed to materialized view.  this is created from tableau.initPipeline which is called from Tableau connection
		  tableau.mVwServiceProduct_EX VwServiceProduct_EX
left join enum.ServiceStatus ss on VwServiceProduct_EX.ServiceStatusId = ss.Id

LEFT JOIN [enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
--LEFT Join oss.VwOrder O on  VwServiceProduct_EX.OrderId = O.Id 
LEFT Join oss.[Order] O on  VwServiceProduct_EX.OrderId = O.Id 
LEFT JOIN [company].[VwAccount] ON O.[AccountId] = [VwAccount].[Ac Id]
left join enum.OrderStatus os on O.OrderStatusId = os.Id
Left join enum.OrderType ot on o.OrderTypeId =  ot.Id
Left join enum.OrderType otm on o.MasterOrderTypeId =  otm.Id
Left join people.VwPerson pm on  case when O.ProjectManagerId = 0 then null else O.ProjectManagerId END   = pm.Id 
--Left join people.VwPerson pm on   O.ProjectManagerId     = pm.Id 
Left join people.VwPerson cb on O.CreatedByPersonId = cb.Id
left join oss.VwOrderItemDetail_EX oi on O.Id = oi.OrderId   AND
 										 VwServiceProduct_EX.ServiceId = oi.ServiceId
left join company.VwLocation l on VwServiceProduct_EX.LocationId = l.[Loc Id]
-- MW 12062018  Adds for Kelly
left join sfdc.VwOpportunity opp on  O.ContractNumber = opp.OpportunityNumber  collate database_default
left join [$(MiBI)].dbo.V_SFDC_PROJECT_INFO p on O.ContractNumber = p.OpportunityNumber  collate database_default
--left join  company.VwContractDetail con on O.SalesContractId = con.SalesContractId
left join  tableau.VwContractLookup con on O.ContractNumber = con.ContractNumber and con.rn=1 --and O.AccountId = con.AccountId 
left join sfdc.Users u on pm.Id = u.BossPersonId and ISNUMERIC(u.BossPersonId) =1
left join tableau.VwMigrationOrderHier mig on O.Id = mig.OrderId
-- MW 05312019  For Evo Pipeline report
left join tableau.VwBossPMRole pmr on pm.Id = pmr.Id and pmr.Instance = 'US'
left join tableau.VwMasterOrderPM mpm on O.Id = mpm.OrderId
-- 11182019 For Taskfeed
--Location
left join [$(MiBI)].dbo.V_SFDC_TASKFEED_INFO tf on opp.OpportunityId = tf.OpportunityId   collate database_default and 
													l.[Loc Id] = tf.BossLocationId and isnumeric(tf.BossLocationId) = 1 and tf.Type= 'Location' and tf.rn = 1
--MiDesign
left join [$(MiBI)].dbo.V_SFDC_TASKFEED_INFO tfm on opp.OpportunityId = tfm.OpportunityId   collate database_default and 
													 isnumeric(tfm.BossLocationId) = 1 and tfm.Type= 'MD' and tfm.rn = 1			
-- Staffing													 
left join tableau.ActivationsStaffing st on st.Staffing_OrderPM_BOSS = COALESCE(mig.PMName, pm.FirstName + ' ' +pm.LastName, cb.FirstName + ' ' +cb.LastName)



