





























































































CREATE VIEW [Tableau].[VwGlobalPipeline_AU]
AS
-- MW 03152018 view for Evodio in Tab Server
--MW 07292019  Segment Views
--SS 2020-12-22 Added Business Term Version
SELECT 'AU' AS Region
	,[Ac Name]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	,[OneTimeCharge]
	,[OneTimeCharge_LC]
	,[MonthlyCharge]
	,[MonthlyCharge_LC]
	,[Prod Category]
	,[ProdSubCategory]
	,[Prod Name]
	,[Prod ShortName]
	-- mw temp replace  06032020
	--,[Class RootName]
	,scon.ContractNumber AS [Order Sales Opp Number]
	--
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,DateSvcLiveScheduled AS ForecastDate
	,DateSvcLiveActual
	,os.[Name] AS OrderStatus
	,ot.[Name] AS OrderType
	,otm.[Name] AS MasterOrderType
	,BillingStage
	,Cluster
	,pm.FirstName
	,pm.LastName
	,o.Id AS OrderId
	,o.DateCreated AS OrderDate
	,CASE 
		WHEN [VwProduct].[Prod Category] = 'Profiles'
			AND VwProduct.[Prod Name] <> 'MiCloud Connect IP Phone User'
			AND oi.OrderItemType = 'New Service'
			THEN oi.Quantity
		ELSE 0
		END AS SeatCount
	,oi.DateBillingStart
	,VwServiceProduct_EX.ServiceId
	,VwServiceProduct_EX.DateSvcCreated
	,l.[Loc Name]
	,ss.[Name] AS ServiceStatus
	,cb.FullName AS OrderCreatedBy
	,VwServiceProduct_EX.[ProductId]
	,pm.FirstName + ' ' + pm.LastName AS [Order PM]
	,str(datediff(day, DateSvcCreated, getdate())) AS [AvgLife Days]
	,opp.[Date Closed] AS OppCloseDate
	,con.StartDate AS ContractStartDate
	,con.DateCreated AS ContractCreateDate
	,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate
	-- MW 05222019 Update logic per Evo
	,ISNULL(VwServiceProduct_EX.DateSvcVoided, CASE 
			WHEN VwServiceProduct_EX.BillingStage = 'Voided'
				THEN VwServiceProduct_EX.DateSvcModified
			WHEN (
					VwServiceProduct_EX.BillingStage = 'Closed'
					AND DateSvcLiveActual IS NULL
					)
				THEN VwServiceProduct_EX.DateSvcModified
			ELSE NULL
			END) AS VoidDate
	--MW 04082019 for Ben
	,[VwAccount].CCClusterName
	,[VwAccount].CCPlatformName
	-- PM Info MW 04152019
	,'' AS SFDC_PM_Role
	,'' AS PM_Id
	,con.ContractType
	--MW 04082019 for Ben
	,[VwAccount].SMRClusterName
	,[VwAccount].SMRPlatformName
	,'AU' + '-' + convert(VARCHAR(10), [VwAccount].[Ac Id]) AS AccountId
	,pmr.BOSSPMRole collate database_default AS BOSSPMRole
	,NULL AS ContractProfileAmount
	,convert(VARCHAR(10), opp.[# Profiles]) AS OppProfileAmount
	,scon.ContractNumber
	--
	,l.StateProvince AS LocationState
	,VwServiceProduct_EX.SvcCluster AS ServiceCluster
	,'      ' AS Master_PMName
	,NULL AS Master_PMId
	,isnull(CASE 
			WHEN tf.Type IS NULL
				THEN tfm.TaskFeedProjectManager
			ELSE tf.TaskFeedProjectManager
			END, p.ProjectOwnerName) AS ProjectOwnerName
	,CASE 
		WHEN tf.Type IS NULL
			AND tfm.Type IS NULL
			AND ss.Name <> 'Active'
			THEN 'No Matching Taskfeed Board Found'
		WHEN tf.Type IS NULL
			AND tfm.Type IS NULL
			AND ss.Name = 'Active'
			THEN p.DelayReason
		WHEN tf.DelayReason IS NULL
			AND tfm.Type IS NOT NULL
			THEN tfm.DelayReason
		ELSE tf.DelayReason
		END AS ProjectDelayReason
	--,isnull(tf.DelayReasonDetails, p.DelayDescription) as ProjectDelayDescription
	,CASE 
		WHEN tf.Type IS NULL
			THEN tfm.DelayReasonDetails
		ELSE tf.DelayReasonDetails
		END AS ProjectDelayDescription
	,VwServiceProduct_EX.MonthMRRLastInvoiced
	,VwServiceProduct_EX.LocationId
	,NULL AS IsMCSSEnabled
	--Taskfeed
	,COALESCE(tf.TF_ProjectNumber, tfm.TF_ProjectNumber) collate database_default AS TF_ProjectNumber
	,COALESCE(tf.TF_StartDate, tfm.TF_StartDate) AS TF_StartDate
	,COALESCE(tf.TF_EndDate, tfm.TF_EndDate) AS TF_EndDate
	,COALESCE(tf.TF_Stage, tfm.TF_Stage) collate database_default AS TF_Stage
	,COALESCE(tf.TF_PctComplete, tfm.TF_PctComplete) AS TF_PctComplete
	--, isnull(cs.CustomerSegmentByProfileSize, 'N/A') as CustomerSegmentByProfileSize
	,'N/A' AS CustomerSegmentByProfileSize
	-- Formula from tableau into datasource for speed
	,CASE 
		WHEN BillingStage = 'Voided'
			THEN 'VOIDED'
		WHEN (
				BillingStage = 'Closed'
				AND DateSvcLiveActual IS NULL
				)
			THEN 'VOIDED'
				--when  BillingStage not in ('Voided', 'Closed')  AND DateSvcLiveActual= VwServiceProduct_EX.DateSvcVoided then 'VOIDED'
		WHEN DateSvcLiveActual = VwServiceProduct_EX.DateSvcVoided
			THEN 'VOIDED'
		WHEN BillingStage = 'Billing'
			AND DateSvcLiveActual IS NULL
			THEN 'VOIDED'
		WHEN BillingStage <> 'Voided'
			AND DateSvcLiveActual < VwServiceProduct_EX.DateSvcVoided
			THEN 'ACTIVATED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND (VwServiceProduct_EX.DateSvcVoided) IS NOT NULL
			THEN 'VOIDED'
		WHEN BillingStage <> 'Voided'
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NOT NULL
			THEN 'ACTIVATED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled IS NULL
			THEN 'UNFORECASTED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled < cast(getdate() AS DATE)
			THEN 'PAST DUE'
		WHEN (BillingStage = 'Closed')
			THEN 'ACTIVATED'
		ELSE 'FORECASTED'
		END AS DS_ActivationStatusRollup
	,st.* --staffing fields
	--,ci.PartnerName  collate database_default as PartnerName
	-- from Opp
	-- MW 09042020 Pull from Account
	--,opp.[Lead Partner]   collate database_default as PartnerName
	,ci.PartnerName collate database_default AS PartnerName
	,ci.CSD_MA collate database_default AS CSD_MA
	,DateSvcClosed AS DateServiceClosed
	,MonthMRRFirstInvoiced AS FirstInvoice
	-- ,tf.[TF Color Number]
	,isnull(tf.[TF Color Number], tfm.[TF Color Number]) AS [TF Color Number]
	,cast(NULL AS DATE) AS MigrationDate
	,CASE 
		WHEN BillingStage = 'Voided'
			THEN 'VOIDED'
		WHEN (
				BillingStage = 'Closed'
				AND DateSvcLiveActual IS NULL
				)
			THEN 'VOIDED'
				--when  BillingStage not in ('Voided', 'Closed')  AND DateSvcLiveActual= VwServiceProduct_EX.DateSvcVoided then 'VOIDED'
		WHEN DateSvcLiveActual = VwServiceProduct_EX.DateSvcVoided
			THEN 'VOIDED'
		WHEN BillingStage = 'Billing'
			AND DateSvcLiveActual IS NULL
			THEN 'VOIDED'
		WHEN BillingStage <> 'Voided'
			AND DateSvcLiveActual < VwServiceProduct_EX.DateSvcVoided
			THEN 'ACTIVATED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND (VwServiceProduct_EX.DateSvcVoided) IS NOT NULL
			THEN 'VOIDED'
		WHEN BillingStage <> 'Voided'
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NOT NULL
			THEN 'ACTIVATED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled IS NULL
			THEN 'UNFORECASTED'
				--when  BillingStage not in ('Voided', 'Closed')  AND VwServiceProduct_EX.DateSvcVoided is null AND DateSvcLiveActual is null  /*  AND COALESCE(tf.TF_EndDate,tfm.TF_EndDate) is null */  	then 'UNFORECASTED'			
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled < cast(getdate() AS DATE)
			THEN 'PAST DUE'
				--when  BillingStage not in ('Voided', 'Closed')  AND VwServiceProduct_EX.DateSvcVoided is null AND DateSvcLiveActual is null   AND (COALESCE(tf.TF_EndDate,tfm.TF_EndDate)-1) < cast(getdate() as Date) 	then 'PAST DUE'			
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled < cast(getdate() AS DATE)
			THEN 'PAST DUE'
		WHEN (BillingStage = 'Closed')
			THEN 'ACTIVATED'
		ELSE 'FORECASTED'
		END AS DS_ActivationStatusRollup_TEST
	,VwServiceProduct_EX.DateBillingValidTo
	,VwServiceProduct_EX.DateSvcSetToActive
	-- is the account a partner?
	,CASE 
		WHEN prtnr.AccountId IS NOT NULL
			THEN 'Yes'
		ELSE 'No'
		END AS isPartnerAccount
	-- New taskfeed MW 03202020
	,tf.TF_PctComplete AS [TF Proj Percent Complete]
	,tf.[TF Tsk Project Start Date Start Date]
	,tf.[TF Tsk Project Start Date Sch End Date]
	,tf.[TF Tsk Project Start Date Complete Date]
	,CASE 
		WHEN ci.AccountId IS NULL
			THEN 'No'
		ELSE 'Yes'
		END AS [Account is in SFDC]
	,ci.CSM AS [Customer Success Manager]
	,tf.[TF Tsk Project Start Date Status] AS [TF Tsk Project Start Date Status]
	,opp.WelcomeContact collate database_default AS [Opportunity Welcome Contact]
	,opp.NCAM collate database_default AS [Opportunity NCAM]
	,opp.AgentCAM collate database_default AS [Opportunity CAM]
	,opp.CommTAM collate database_default AS [Opportunity C-TAM]
	,opp.AdvancedISRId collate database_default AS [Opportunity ISR]
	,opp.SubAgent collate database_default AS [Opportunity Sub Agent]
	,opp.ShoreTelTerritory collate database_default AS [Opportunity Territory]
	,COALESCE(tf.[TF Board Sfdc Id], tfm.[TF Board Sfdc Id]) collate database_default AS [TF Board Sfdc Id]
	,COALESCE(tf.[TF Tsk BRD Sign-Off Start Date], tfm.[TF Tsk BRD Sign-Off Start Date]) AS [TF Tsk BRD Sign-Off Start Date]
	,COALESCE(tf.[TF Tsk BRD Sign-Off End Date], tfm.[TF Tsk BRD Sign-Off End Date]) AS [TF Tsk BRD Sign-Off End Date]
	,COALESCE(tf.[TF Tsk BRD Sign-Off Complete Date], tfm.[TF Tsk BRD Sign-Off Complete Date]) AS [TF Tsk BRD Sign-Off Complete Date]
	,COALESCE(tf.[TF Tsk BRD Sign-Off Status], tfm.[TF Tsk BRD Sign-Off Status]) collate database_default AS [TF Tsk BRD Sign-Off Status]
	,tf.[TF Tsk Trans To Support Start Date] [TF Tsk Trans To Support Start Date]
	,tf.[TF Tsk Trans To Support Sch End Date] [TF Tsk Trans To Support Sch End Date]
	,tf.[TF Tsk Trans To Support Complete Date] [TF Tsk Trans To Support Complete Date]
	,tf.[TF Tsk Trans To Support Status] collate database_default AS [TF Tsk Trans To Support Status]
	,tf.[TF Board Last Modified]
	,cast(NULL AS DATETIME) AS ServiceCommitmentDate
	,COALESCE(tf.[TF Tsk Cust Audit Approval Start Date], tfm.[TF Tsk Cust Audit Approval Start Date]) AS [TF Tsk Cust Audit Approval Start Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval End Date], tfm.[TF Tsk Cust Audit Approval End Date]) AS [TF Tsk Cust Audit Approval End Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval Complete Date], tfm.[TF Tsk Cust Audit Approval Complete Date]) AS [TF Tsk Cust Audit Approval Complete Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval Status], tfm.[TF Tsk Cust Audit Approval Status]) collate database_default AS [TF Tsk Cust Audit Approval Status]
	,COALESCE(tf.[Accelerated Timeline Initiative Update Date], tfm.[Accelerated Timeline Initiative Update Date]) [Accelerated Timeline Initiative Update Date]
	,COALESCE(tf.[Accelerated Timeline Initiative Description], tfm.[Accelerated Timeline Initiative Description]) collate database_default AS [Accelerated Timeline Initiative Description]
	,CASE WHEN CAST(scon.BusinessTermVersion AS NUMERIC(9, 2)) IS NULL 
		THEN 0.0 --MAX(CAST(scon.BusinessTermVersion AS NUMERIC(9, 2))) OVER(PARTITION BY scon.ContractNumber) 
		ELSE CAST(scon.BusinessTermVersion AS NUMERIC(9, 2)) 
	 END AS BusinessTermVersion
	,tf.[TF Tsk Port In Research Start Date]
	,tf.[TF Tsk Port In Research End Date]
	,tf.[TF Tsk Port In Research Complete Date]
	,tf.[TF Tsk Port In Research Status] collate database_default AS [TF Tsk Port In Research Status]
	,tf.[TF Tsk Order New Numbers Start Date]
	,tf.[TF Tsk Order New Numbers End Date]
	,tf.[TF Tsk Order New Numbers Complete Date]
	,tf.[TF Tsk Order New Numbers Status] collate database_default AS [TF Tsk Order New Numbers Status]
	,tf.[TF Tsk Order Hardware Start Date]
	,tf.[TF Tsk Order Hardware End Date]
	,tf.[TF Tsk Order Hardware Complete Date]
	,tf.[TF Tsk Order Hardware Status] collate database_default AS [TF Tsk Order Hardware Status]
	,tf.[TF Tsk Port Submitted Start Date]
	,tf.[TF Tsk Port Submitted End Date]
	,tf.[TF Tsk Port Submitted Complete Date]
	,tf.[TF Tsk Port Submitted Status] collate database_default AS [TF Tsk Port Submitted Status]
	,tf.[TF Tsk System Programming Start Date]
	,tf.[TF Tsk System Programming End Date]
	,tf.[TF Tsk System Programming Complete Date]
	,tf.[TF Tsk System Programming Status] collate database_default AS [TF Tsk System Programming Status]
	,tf.[TF Tsk Ready To Test Start Date]
	,tf.[TF Tsk Ready To Test End Date]
	,tf.[TF Tsk Ready To Test Complete Date]
	,tf.[TF Tsk Ready To Test Status] collate database_default AS [TF Tsk Ready To Test Status]
	,tf.[TF Tsk Port Scheduled Start Date]
	,tf.[TF Tsk Port Scheduled End Date]
	,tf.[TF Tsk Port Scheduled Complete Date]
	,tf.[TF Tsk Port Scheduled Status] collate database_default AS [TF Tsk Port Scheduled Status]
	,tf.[TF Tsk Pre Go Live Testing Start Date]
	,tf.[TF Tsk Pre Go Live Testing End Date]
	,tf.[TF Tsk Pre Go Live Testing Compelte Date]
	,tf.[TF Tsk Pre Go Live Testing Status] collate database_default AS [TF Tsk Pre Go Live Testing Status]
	-- Opp Note info
	,opp.NoteId collate database_default AS NoteId
	,opp.NoteTitle collate database_default AS NoteTitle
	,opp.NoteModifiedDate
	,opp.NoteModifiedBy collate database_default AS NoteModifiedBy
	,'AU-' + convert(VARCHAR(15), con.Id) AS ContractId
	,1 MigrationOrderId
	,'x' MigrationOrderStatus
	,'x' AS MigrationCloseOrderStatus
	--,getdate()   as MigrationCloseOrderDeprovisionDate
	,getdate() AS MigrationOrderDeprovisionDate
	,'AU' + '-' + convert(VARCHAR(10), sc3.OrderSalesContractId) AS OrderSalesContractId
	--,ss2.DateOrdered as PortingOrderDate
	--,cast(NULL AS DATETIME) AS PortingOrderDate
	,ss2.DateOrdered as PortingOrderDate
	,ss2.[DateRequested] as LNPRequestDate
	,ss2.FOCDate
	,COALESCE(tf.TaskfeedBoardType, tfm.TaskfeedBoardType) collate database_default AS TaskfeedBoardType
	,tf.[TF Tsk Net Readiness Start Date]
	,tf.[TF Tsk Net Readiness End Date]
	,tf.[TF Tsk Net Readiness Complete Date]
	,tf.[TF Tsk Net Readiness Status] collate database_default AS [TF Tsk Net Readiness Status]
	,COALESCE(tf.TF_Project_Board_Notes, tfm.TF_Project_Board_Notes) collate database_default AS TF_Project_Board_Notes
	,COALESCE(tf.TF_External_Sharing, tfm.TF_External_Sharing) collate database_default AS TF_External_Sharing
	,opp.RecordType collate database_default AS OppRecordType
	,opp.[Opportunity Type] collate database_default AS OppType
	,opp.Stage collate database_default AS OppStage
	,opp.OppOwner collate database_default AS OppOwner
	,ci.PartnerName collate database_default AS [Partner of Record Cloud]
	,ci.PartnerName_Onsite collate database_default AS [Partner of Record Onsite]
	,ci.[BOSS_Support_Partner__c]
	,ci.[MiCloud_Connect_Business_Model__c]
	,ci.[PartnerDisplayName__c]
	,ci.[PartnerSupportEmailAddress__c]
	,ci.[PartnerSupportInformation__c]
	,ci.[PartnerSupportPhoneNumber__c]
	,ci.[PartnerSupportWebPage__c]
	,ci.[Support_Partner_Enabled__c]
	,ss2.[Total #s to LNP] AS [Total #s to LNP]
	,tfm.[TF Board Last Modified] AS [TF_MDBoard_Mod_Date]
	,CASE 
		WHEN tfm.OpportunityId IS NULL
			THEN 'No Matching MiDesign Board'
		ELSE tfm.DelayReason
		END collate database_default AS TF_MDBoard_Delay_Reason
	,dbo.UfnRemoveUnprintableChar(tfm.TF_Project_Board_Notes) collate database_default AS TF_MDBoard_Notes
	,tfm.DelayReasonDetails collate database_default AS TF_MDBoard_Delay_Description
	,tfm.TF_ProjectNumber collate database_default AS TF_MDBoard_Project_Number
	,tfm.[TF Board Sfdc Id] collate database_default AS TF_MDBoard_SFDCID
	,opp.[Debooked Opportunity]
	,tf.[PRA Score] collate database_default AS [PRA Score]
	,spp.ParentProfile collate database_default AS [Parent Profile]
	,oi.DateProcessed AS OrderCloseDate
FROM AU_FinanceBI.oss.VwServiceProduct_EX
LEFT JOIN AU_FinanceBI.enum.ServiceStatus ss(NOLOCK) ON VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN AU_FinanceBI.[enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
LEFT JOIN AU_FinanceBI.oss.[Order] O(NOLOCK) ON VwServiceProduct_EX.OrderId = O.Id
LEFT JOIN AU_FinanceBI.[company].[VwAccount] ON O.[AccountId] = [VwAccount].[Ac Id]
LEFT JOIN AU_FinanceBI.enum.OrderStatus os(NOLOCK) ON O.OrderStatusId = os.Id
LEFT JOIN AU_FinanceBI.oss.[Order] O2(NOLOCK) ON O.MasterOrderId = O2.Id
LEFT JOIN AU_FinanceBI.enum.OrderType ot(NOLOCK) ON o.OrderTypeId = ot.Id
LEFT JOIN AU_FinanceBI.enum.OrderType otm(NOLOCK) ON O2.OrderTypeId = otm.Id
LEFT JOIN AU_FinanceBI.people.VwPerson pm ON VwServiceProduct_EX.OrderProjectManagerId = pm.Id
LEFT JOIN AU_FinanceBI.oss.VwOrderItemDetail oi ON o.Id = oi.OrderId
	AND VwServiceProduct_EX.ServiceId = oi.ServiceId
LEFT JOIN AU_FinanceBI.people.VwPerson cb ON VwServiceProduct_EX.CreatedByPersonId = cb.Id
LEFT JOIN AU_FinanceBI.company.VwLocation l ON VwServiceProduct_EX.LocationId = l.[Loc Id]
-- Accounting for linked adds  MW 06082020
LEFT JOIN (
	SELECT o.Id
		,oo.OrderSalesContractId
	FROM AU_FinanceBI.oss.[Order] o(NOLOCK)
	INNER JOIN AU_FinanceBI.oss.[Order] oo(NOLOCK) ON o.LinkedOrderId = oo.Id
	WHERE o.OrderTypeId = 9 --Linked Add
		AND oo.OrderSalesContractId IS NOT NULL
	
	UNION ALL
	
	SELECT Id
		,OrderSalesContractId
	FROM AU_FinanceBI.oss.[Order] o(NOLOCK)
	WHERE OrderTypeId <> 9
		AND OrderSalesContractId IS NOT NULL
	) sc3 ON o.Id = sc3.Id
--Direct Linked Contract Info MW 06032020
LEFT JOIN AU_FinanceBI.sales.VwContract scon(NOLOCK) ON sc3.OrderSalesContractId = scon.Id
-- MW 05192020 mat View
LEFT JOIN sfdc.mVwOpportunity opp(NOLOCK) ON scon.ContractNumber = opp.OpportunityNumber collate database_default
LEFT JOIN [$(MiBI)].dbo.V_SFDC_PROJECT_INFO p ON scon.ContractNumber = p.OpportunityNumber collate database_default
LEFT JOIN AU_FinanceBI.company.VwContractDetail con ON scon.ContractNumber = con.OpportunityNumber
LEFT JOIN tableau.VwBossPMRole pmr ON pm.Id = pmr.Id
	AND pmr.Instance = 'AU'
-- 11182019 For Taskfeed
LEFT JOIN Tableau.mVwTaskfeedInfo tf(NOLOCK) ON 'AU-' + convert(VARCHAR(10), [Loc Id]) = tf.BossLocationId
	AND scon.ContractNumber = tf.OpportunityNumber collate database_default
	AND tf.BossLocationId LIKE 'AU-%'
	AND tf.Type = 'Location'
	AND tf.rn = 1
--MiDesign
LEFT JOIN Tableau.mVwTaskfeedInfo tfm(NOLOCK) ON scon.ContractNumber = tfm.OpportunityNumber collate database_default
	AND tfm.Type = 'MD'
	AND tfm.rn = 1
-- MW 12052019 Segment Loaded from nightly job
--left join tableau.CustomerSegments cs on VwAccount.[Ac Id] = cs.AccountId	
-- Staffing													 
LEFT JOIN tableau.ActivationsStaffing st(NOLOCK) ON st.Staffing_OrderPM_BOSS = pm.FirstName + ' ' + pm.LastName
-- Cust Info
LEFT JOIN Tableau.mVwSFDCCustInfo ci(NOLOCK) ON 'AU-' + convert(VARCHAR(10), VwAccount.[Ac Id]) = ci.AccountId collate database_default
	AND isnumeric(ci.AccountId) = 0
	AND ci.AccountId LIKE 'AU-%'
-- MW 02252020  Need to know if account is partner
LEFT JOIN AU_FinanceBI.company.Partner prtnr(NOLOCK) ON VwAccount.[Ac Id] = prtnr.AccountId
LEFT JOIN AU_FinanceBI.oss.ServiceSettings ss2(NOLOCK) ON VwServiceProduct_EX.ServiceId = ss2.ServiceId
LEFT JOIN AU_FinanceBI.oss.ServiceParentProfile spp(NOLOCK) ON spp.ServiceId = VwServiceProduct_EX.ServiceId
