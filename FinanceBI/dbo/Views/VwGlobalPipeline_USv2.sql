


Create View VwGlobalPipeline_USv2 as
-- Creating with Materialzed contracts
SELECT 'US' AS Region
	,[Ac Name]
	,[IsBillable]
	,[Ac Team]
	,[Platform]
	-- per evodio MW 07182019
	,CASE 
		WHEN VwServiceProduct_EX.ServiceId IN (
				2350684
				,2350685
				,2350690
				,2350691
				,2350692
				,2366074
				)
			THEN 0
		ELSE [OneTimeCharge]
		END AS OneTimeCharge
	,CASE 
		WHEN VwServiceProduct_EX.ServiceId IN (
				2350684
				,2350685
				,2350690
				,2350691
				,2350692
				,2366074
				)
			THEN 0
		ELSE [OneTimeCharge_LC]
		END AS OneTimeCharge_LC
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
	,COALESCE(mig.OrderType, ot.Name) AS OrderType
	,COALESCE(mig.MasterOrderType, otm.Name) AS MasterOrderType
	-- Per Evo MW05292019
	,CASE 
		WHEN (
				BillingStage = 'Closed'
				AND DateSvcLiveActual IS NULL
				)
			THEN 'Voided'
		ELSE BillingStage
		END AS BillingStage
	,Cluster
	,pm.FirstName
	,pm.LastName
	,O.Id AS OrderId
	,o.DateCreated AS OrderDate
	,CASE 
		WHEN [enum].[VwProduct].[Prod Category] = 'Profiles'
			AND oi.OrderItemType = 'New Service'
			AND enum.VwProduct.[Prod Name] <> 'MiCloud Connect IP Phone User' -- per Evo MW 07092019
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
	,COALESCE(mig.PMName, pm.FirstName + ' ' + pm.LastName, cb.FirstName + ' ' + cb.LastName) AS [Order PM]
	,str(datediff(day, DateSvcCreated, getdate())) AS [AvgLife Days]
	-- MW 12062018  Adds for Kelly
	,opp.[Date Closed] AS OppCloseDate
	,con.StartDate AS ContractStartDate
	,con.DateCreated AS ContractCreateDate
	,opp.OpportunityNumber
	--, Case when O.OrderStatus = 'Void' then O.DateModified else null End as VoidDate
	-- MW 05222019 Update logic per Evo
	,ISNULL(VwServiceProduct_EX.DateSvcVoided, CASE 
			WHEN (VwServiceProduct_EX.BillingStage = 'Voided')
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
	--, convert(varchar(255), u.RoleName )  as SFDC_PM_Role
	--,u.RoleName collate database_default AS SFDC_PM_Role
	
	,cast ( null as varchar(5) )  collate database_default AS SFDC_PM_Role
	
	,pm.Id AS PM_Id
	,isnull(con.ContractType, 'Other') AS ContractType
	--MW 04082019 for Ben
	,[VwAccount].SMRClusterName
	,[VwAccount].SMRPlatformName
	,'US' + '-' + convert(VARCHAR(10), [VwAccount].[Ac Id]) AS AccountId
	,pmr.BOSSPMRole
	,con.ContractProfileAmount
	,convert(VARCHAR(10), opp.[# Profiles]) AS OppProfileAmount
	,scon.ContractNumber
	--
	,l.StateProvince AS LocationState
	,VwServiceProduct_EX.SvcCluster AS ServiceCluster
	,mpm.Master_PMName
	,mpm.Master_PMId
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
	,VwAccount.IsMCSSEnabled
	--Taskfeed
	,COALESCE(tf.TF_ProjectNumber, tfm.TF_ProjectNumber) collate database_default AS TF_ProjectNumber
	,COALESCE(tf.TF_StartDate, tfm.TF_StartDate) AS TF_StartDate
	,COALESCE(tf.TF_EndDate, tfm.TF_EndDate) AS TF_EndDate
	,COALESCE(tf.TF_Stage, tfm.TF_Stage) collate database_default AS TF_Stage
	,COALESCE(tf.TF_PctComplete, tfm.TF_PctComplete) AS TF_PctComplete
	,isnull(cs.CustomerSegmentByProfileSize, 'N/A') AS CustomerSegmentByProfileSize
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
	--,st.*  --staffing fields
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_WorkdayName]
		END AS Staffing_WorkdayName
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderPM_BOSS]
		END AS [Staffing_OrderPM_BOSS]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssignee]
		END AS [Staffing_OrderAssignee]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssigneeManager]
		END AS [Staffing_OrderAssigneeManager]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssigneeGroup]
		END AS [Staffing_OrderAssigneeGroup]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssigneeCenter]
		END AS [Staffing_OrderAssigneeCenter]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssigneeRegion]
		END AS [Staffing_OrderAssigneeRegion]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Active'
		ELSE [Staffing_OrderAssigneeStatus]
		END AS [Staffing_OrderAssigneeStatus]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 'Self Service'
		ELSE [Staffing_OrderAssigneePOD]
		END AS [Staffing_OrderAssigneePOD]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN '11/1/19'
		ELSE [Staffing_OrderAssigneeStartDate]
		END AS [Staffing_OrderAssigneeStartDate]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN '12/31/2999'
		ELSE [Staffing_OrderAssigneeEndDate]
		END AS [Staffing_OrderAssigneeEndDate]
	,CASE 
		WHEN VwAccount.IsMCSSEnabled = 1
			THEN 0
		ELSE [Staffing_CalcPMMRRGoalfortheMonth]
		END AS Staffing_CalcPMMRRGoalfortheMonth
	--,ci.PartnerName  collate database_default as PartnerName
	-- from Opp
	-- MW 09042020 Pull from Account
	--,opp.[Lead Partner]   collate database_default as PartnerName
	,ci.PartnerName collate database_default AS PartnerName
	,ci.CSD_MA collate database_default AS CSD_MA
	,DateSvcClosed AS DateServiceClosed
	,MonthMRRFirstInvoiced AS FirstInvoice
	--,tf.[TF Color Number]
	,isnull(tf.[TF Color Number], tfm.[TF Color Number]) AS [TF Color Number]
	,CASE 
		WHEN O.MasterOrderTypeId = 6
			AND O.OrderSubtypeId IN (
				7
				,8
				)
			THEN O.DateLiveScheduled
		ELSE NULL
		END MigrationDate
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
			AND isnull(COALESCE(mig.MasterOrderType, otm.Name), 'x') <> 'Migration' collate database_default
			THEN 'UNFORECASTED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND COALESCE(mig.MasterOrderType, otm.Name) = 'Migration' collate database_default
			AND COALESCE(tf.TF_EndDate, tfm.TF_EndDate) IS NULL
			THEN 'UNFORECASTED'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND DateSvcLiveScheduled < cast(getdate() AS DATE)
			AND mig.MasterOrderType <> 'Migration' collate database_default
			THEN 'PAST DUE'
		WHEN BillingStage NOT IN (
				'Voided'
				,'Closed'
				)
			AND VwServiceProduct_EX.DateSvcVoided IS NULL
			AND DateSvcLiveActual IS NULL
			AND COALESCE(mig.MasterOrderType, otm.Name) = 'Migration' collate database_default
			AND (COALESCE(tf.TF_EndDate, tfm.TF_EndDate) - 1) < cast(getdate() AS DATE)
			THEN 'PAST DUE'
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
	,COALESCE(tf.TF_PctComplete, tfm.TF_PctComplete) AS [TF Proj Percent Complete]
	,COALESCE(tf.[TF Tsk Project Start Date Start Date], tfm.[TF Tsk Project Start Date Start Date]) [TF Tsk Project Start Date Start Date]
	,COALESCE(tf.[TF Tsk Project Start Date Sch End Date], tfm.[TF Tsk Project Start Date Sch End Date]) [TF Tsk Project Start Date Sch End Date]
	,COALESCE(tf.[TF Tsk Project Start Date Complete Date], tfm.[TF Tsk Project Start Date Complete Date]) [TF Tsk Project Start Date Complete Date]
	,CASE 
		WHEN ci.AccountId IS NULL
			THEN 'No'
		ELSE 'Yes'
		END AS [Account is in SFDC]
	,ci.CSM AS [Customer Success Manager]
	,COALESCE(tf.[TF Tsk Project Start Date Status], tfm.[TF Tsk Project Start Date Status]) AS [TF Tsk Project Start Date Status]
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
	,COALESCE(tf.[TF Tsk Trans To Support Start Date], tfm.[TF Tsk Trans To Support Start Date]) [TF Tsk Trans To Support Start Date]
	,COALESCE(tf.[TF Tsk Trans To Support Sch End Date], tfm.[TF Tsk Trans To Support Sch End Date]) [TF Tsk Trans To Support Sch End Date]
	,COALESCE(tf.[TF Tsk Trans To Support Complete Date], tfm.[TF Tsk Trans To Support Complete Date]) [TF Tsk Trans To Support Complete Date]
	,COALESCE(tf.[TF Tsk Trans To Support Status], tfm.[TF Tsk Trans To Support Status]) collate database_default AS [TF Tsk Trans To Support Status]
	,COALESCE(tf.[TF Board Last Modified], tfm.[TF Board Last Modified]) [TF Board Last Modified]
	,con.CommitmentDate AS ServiceCommitmentDate
	,COALESCE(tf.[TF Tsk Cust Audit Approval Start Date], tfm.[TF Tsk Cust Audit Approval Start Date]) AS [TF Tsk Cust Audit Approval Start Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval End Date], tfm.[TF Tsk Cust Audit Approval End Date]) AS [TF Tsk Cust Audit Approval End Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval Complete Date], tfm.[TF Tsk Cust Audit Approval Complete Date]) AS [TF Tsk Cust Audit Approval Complete Date]
	,COALESCE(tf.[TF Tsk Cust Audit Approval Status], tfm.[TF Tsk Cust Audit Approval Status]) collate database_default AS [TF Tsk Cust Audit Approval Status]
	,COALESCE(tf.[Accelerated Timeline Initiative Update Date], tfm.[Accelerated Timeline Initiative Update Date]) [Accelerated Timeline Initiative Update Date]
	,COALESCE(tf.[Accelerated Timeline Initiative Description], tfm.[Accelerated Timeline Initiative Description]) collate database_default AS [Accelerated Timeline Initiative Description]
	,CASE WHEN CAST(scon.BusinessTermVersion AS NUMERIC(9, 2)) IS NULL 
		THEN MAX(CAST(scon.BusinessTermVersion AS NUMERIC(9, 2))) OVER(PARTITION BY scon.ContractNumber) 
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
	,con.ContractId
	-- MW 05202020 Migration info
	,mig.MigrationOrderId
	,mig.MigrationOrderStatus
	,mco.CloseOrderStatus AS MigrationCloseOrderStatus
	--,mco.CloseOrderDeprovisionDate as MigrationCloseOrderDeprovisionDate
	--,mig.MigrationOrderDeprovisionDate 
	,mco.CloseOrderDeprovisionDate AS MigrationOrderDeprovisionDate
	,'US' + '-' + convert(VARCHAR(10), sc3.OrderSalesContractId) AS OrderSalesContractId
	,ss2.DateOrdered as PortingOrderDate
	,ss2.[DateRequested] as LNPRequestDate
	,ss2.[FOCDate]
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
	,spp.ParentProfile  collate database_default AS [Parent Profile]
	,oi.DateProcessed AS OrderCloseDate
FROM --oss.VwServiceProduct_EX
	-- MW 05212019  changed to materialized view.  this is created from tableau.initPipeline which is called from Tableau connection
	tableau.mVwServiceProduct_EX VwServiceProduct_EX(NOLOCK)
LEFT JOIN enum.ServiceStatus ss(NOLOCK) ON VwServiceProduct_EX.ServiceStatusId = ss.Id
LEFT JOIN [enum].[VwProduct] ON VwServiceProduct_EX.[ProductId] = [VwProduct].[Prod Id]
--LEFT Join oss.VwOrder O on  VwServiceProduct_EX.OrderId = O.Id 
LEFT JOIN oss.[Order] O(NOLOCK) ON VwServiceProduct_EX.OrderId = O.Id
LEFT JOIN [company].[VwAccount] ON O.[AccountId] = [VwAccount].[Ac Id]
LEFT JOIN enum.OrderStatus os(NOLOCK) ON O.OrderStatusId = os.Id
LEFT JOIN enum.OrderType ot(NOLOCK) ON o.OrderTypeId = ot.Id
LEFT JOIN enum.OrderType otm(NOLOCK) ON o.MasterOrderTypeId = otm.Id
LEFT JOIN people.VwPerson pm ON CASE 
		WHEN O.ProjectManagerId = 0
			THEN NULL
		ELSE O.ProjectManagerId
		END = pm.Id
--Left join people.VwPerson pm on   O.ProjectManagerId     = pm.Id 
LEFT JOIN people.VwPerson cb ON O.CreatedByPersonId = cb.Id
LEFT JOIN oss.VwOrderItemDetail_EX oi ON O.Id = oi.OrderId
	AND VwServiceProduct_EX.ServiceId = oi.ServiceId
LEFT JOIN company.VwLocation l ON VwServiceProduct_EX.LocationId = l.[Loc Id]
-- Accounting for linked adds  MW 06082020
LEFT JOIN (
	SELECT o.Id
		,oo.OrderSalesContractId
	FROM oss.[Order] o(NOLOCK)
	INNER JOIN oss.[Order] oo(NOLOCK) ON o.LinkedOrderId = oo.Id
	WHERE o.OrderTypeId = 9 --Linked Add
		AND oo.OrderSalesContractId IS NOT NULL
	
	UNION ALL
	
	SELECT Id
		,OrderSalesContractId
	FROM oss.[Order] o(NOLOCK)
	WHERE OrderTypeId <> 9
		AND OrderSalesContractId IS NOT NULL
	) sc3 ON o.Id = sc3.Id
--Direct Linked Contract Info MW 06032020
LEFT JOIN sales.VwContract scon ON sc3.OrderSalesContractId = scon.Id
-- MW 12062018  Adds for Kelly
-- MW 05192020 mat View
LEFT JOIN sfdc.mVwOpportunity opp(NOLOCK) ON --O.ContractNumber = opp.OpportunityNumber  collate database_default
	-- MW 07142020 Change linkage to contract
	scon.ContractNumber = opp.OpportunityNumber collate database_default
LEFT JOIN [$(MiBI)].dbo.V_SFDC_PROJECT_INFO p ON --O.ContractNumber = p.OpportunityNumber  collate database_default
	scon.ContractNumber = p.OpportunityNumber collate database_default
--left join  company.VwContractDetail con on O.SalesContractId = con.SalesContractId
LEFT JOIN tableau.mVwContractLookup con ON scon.ContractNumber = con.ContractNumber   --################## materialize
	AND con.rn = 1 --and O.AccountId = con.AccountId 
	
	-- MW 12282020 removing
--LEFT JOIN sfdc.Users u(NOLOCK) ON pm.Id = u.BossPersonId
	--AND ISNUMERIC(u.BossPersonId) = 1
	
	
LEFT JOIN tableau.VwMigrationOrderHier mig ON O.Id = mig.OrderId
-- MW 05312019  For Evo Pipeline report
LEFT JOIN tableau.VwBossPMRole pmr ON pm.Id = pmr.Id
	AND pmr.Instance = 'US'
LEFT JOIN tableau.VwMasterOrderPM mpm ON O.Id = mpm.OrderId
-- 11182019 For Taskfeed
--Location
LEFT JOIN Tableau.mVwTaskfeedInfo tf(NOLOCK) ON scon.ContractNumber = tf.OpportunityNumber collate database_default
	AND l.[Loc Id] = tf.BossLocationId
	AND isnumeric(tf.BossLocationId) = 1
	AND tf.Type = 'Location'
	AND tf.rn = 1
--MiDesign
LEFT JOIN Tableau.mVwTaskfeedInfo tfm(NOLOCK) ON scon.ContractNumber = tfm.OpportunityNumber collate database_default
	AND tfm.Type = 'MD'
	AND tfm.rn = 1
-- MW 12052019 Segment Loaded from nightly job
LEFT JOIN tableau.CustomerSegments cs(NOLOCK) ON VwAccount.[Ac Id] = cs.AccountId
-- Staffing									 
--left join tableau.ActivationsStaffing st on st.Staffing_OrderPM_BOSS = COALESCE(mig.PMName, pm.FirstName + ' ' +pm.LastName, cb.FirstName + ' ' +cb.LastName)
--	Look up based Project Owner instead of Order -Evo 02102020	
--left join tableau.ActivationsStaffing st on st.Staffing_OrderPM_BOSS = COALESCE(CASE WHEN mig.MasterOrderType  = 'Migration' collate database_default then COALESCE(tf.TaskFeedProjectManager,tfm.TaskFeedProjectManager,p.ProjectOwnerName) collate database_default ELSE NULL END
--																				, pm.FirstName + ' ' +pm.LastName, cb.FirstName + ' ' +cb.LastName)	
-- MW 11232020 Updates per Evodio
LEFT JOIN tableau.ActivationsStaffing st(NOLOCK) ON st.Staffing_OrderPM_BOSS = COALESCE(CASE 
			WHEN mig.MasterOrderType = 'Migration' collate database_default
				THEN COALESCE(tf.TaskFeedProjectManager, tfm.TaskFeedProjectManager, 'Unassigned') collate database_default
			ELSE NULL
			END, tf.TaskFeedProjectManager, tfm.TaskFeedProjectManager, CASE 
			WHEN (
					tf.OpportunityNumber IS NOT NULL
					OR tfm.OpportunityNumber IS NOT NULL
					)
				THEN 'Unassigned'
			ELSE NULL
			END, pm.FirstName + ' ' + pm.LastName, cb.FirstName + ' ' + cb.LastName)
-- Cust Info
LEFT JOIN Tableau.mVwSFDCCustInfo ci(NOLOCK) ON VwAccount.[Ac Id] = ci.AccountId collate database_default
	AND isnumeric(ci.AccountId) = 1
-- MW 02252020  Need to know if account is partner
LEFT JOIN company.Partner prtnr(NOLOCK) ON VwAccount.[Ac Id] = prtnr.AccountId
-- MW 05202020  Migration Close Order Info
LEFT JOIN tableau.VwMigCloseOrderDetail mco ON mig.MigrationOrderId = mco.MasterOrderId
	AND l.[Loc Id] = mco.LocationId
LEFT JOIN oss.ServiceSettings ss2(NOLOCK) ON VwServiceProduct_EX.ServiceId = ss2.ServiceId
LEFT JOIN oss.ServiceParentProfile spp(NOLOCK) ON spp.ServiceId = VwServiceProduct_EX.ServiceId

