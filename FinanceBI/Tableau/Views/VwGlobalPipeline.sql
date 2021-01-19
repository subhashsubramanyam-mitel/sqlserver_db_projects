




















































































--select * from [Tableau].[VwGlobalPipeline] where Region = 'US'
CREATE VIEW [Tableau].[VwGlobalPipeline]
AS
-- MW 03152018 view for Evodio in Tab Server
-- MW 08202019 Combine for hourly updates in Tableau
SELECT [Region]
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
	,[Order Sales Opp Number]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,[ForecastDate]
	,[DateSvcLiveActual]
	,[OrderStatus]
	,[OrderType]
	,[MasterOrderType]
	,[BillingStage]
	,[Cluster]
	,[FirstName]
	,[LastName]
	,[OrderId]
	,[OrderDate]
	,[SeatCount]
	,[DateBillingStart]
	,[ServiceId]
	,[DateSvcCreated]
	,[Loc Name]
	,[ServiceStatus]
	,[OrderCreatedBy]
	,[ProductId]
	,[Order PM]
	,[AvgLife Days]
	,[OppCloseDate]
	,[ContractStartDate]
	,[ContractCreateDate]
	,[OpportunityNumber]
	,[VoidDate]
	,[CCClusterName]
	,[CCPlatformName]
	,[SFDC_PM_Role]
	,[PM_Id]
	,[ContractType]
	,[SMRClusterName]
	,[SMRPlatformName]
	,[AccountId]
	,[BOSSPMRole]
	,[ContractProfileAmount]
	,[OppProfileAmount]
	,[ContractNumber]
	,[LocationState]
	,[ServiceCluster]
	,[Master_PMName]
	,[Master_PMId]
	,[ProjectOwnerName]
	,[ProjectDelayReason]
	,[ProjectDelayDescription]
	,[MonthMRRLastInvoiced]
	,[LocationId]
	,[IsMCSSEnabled]
	,[TF_ProjectNumber]
	,[TF_StartDate]
	,[TF_EndDate]
	,[TF_Stage]
	,[TF_PctComplete]
	,[CustomerSegmentByProfileSize]
	,[DS_ActivationStatusRollup]
	,[Staffing_WorkdayName]
	,[Staffing_OrderPM_BOSS]
	,[Staffing_OrderAssignee]
	,[Staffing_OrderAssigneeManager]
	,[Staffing_OrderAssigneeGroup]
	,[Staffing_OrderAssigneeCenter]
	,[Staffing_OrderAssigneeRegion]
	,[Staffing_OrderAssigneeStatus]
	,[Staffing_OrderAssigneePOD]
	,[Staffing_OrderAssigneeStartDate]
	,[Staffing_OrderAssigneeEndDate]
	,[Staffing_CalcPMMRRGoalfortheMonth]
	,[PartnerName]
	,[CSD_MA]
	,[DateServiceClosed]
	,[FirstInvoice]
	,[TF Color Number]
	,[MigrationDate]
	,[DS_ActivationStatusRollup_TEST]
	,[DateBillingValidTo]
	,[DateSvcSetToActive]
	,[isPartnerAccount]
	,[TF Proj Percent Complete]
	,[TF Tsk Project Start Date Start Date]
	,[TF Tsk Project Start Date Sch End Date]
	,[TF Tsk Project Start Date Complete Date]
	,[Account is in SFDC]
	,[Customer Success Manager]
	,[TF Tsk Project Start Date Status]
	,[Opportunity Welcome Contact]
	,[Opportunity NCAM]
	,[Opportunity CAM]
	,[Opportunity C-TAM]
	,[Opportunity ISR]
	,[Opportunity Sub Agent]
	,[Opportunity Territory]
	,[TF Board Sfdc Id]
	,[TF Tsk BRD Sign-Off Start Date]
	,[TF Tsk BRD Sign-Off End Date]
	,[TF Tsk BRD Sign-Off Complete Date]
	,[TF Tsk BRD Sign-Off Status]
	,[TF Tsk Trans To Support Start Date]
	,[TF Tsk Trans To Support Sch End Date]
	,[TF Tsk Trans To Support Complete Date]
	,[TF Tsk Trans To Support Status]
	,[TF Board Last Modified]
	,[ServiceCommitmentDate]
	,[TF Tsk Cust Audit Approval Start Date]
	,[TF Tsk Cust Audit Approval End Date]
	,[TF Tsk Cust Audit Approval Complete Date]
	,[TF Tsk Cust Audit Approval Status]
	,[Accelerated Timeline Initiative Update Date]
	,[Accelerated Timeline Initiative Description]
	,[BusinessTermVersion]
	,[TF Tsk Port In Research Start Date]
	,[TF Tsk Port In Research End Date]
	,[TF Tsk Port In Research Complete Date]
	,[TF Tsk Port In Research Status]
	,[TF Tsk Order New Numbers Start Date]
	,[TF Tsk Order New Numbers End Date]
	,[TF Tsk Order New Numbers Complete Date]
	,[TF Tsk Order New Numbers Status]
	,[TF Tsk Order Hardware Start Date]
	,[TF Tsk Order Hardware End Date]
	,[TF Tsk Order Hardware Complete Date]
	,[TF Tsk Order Hardware Status]
	,[TF Tsk Port Submitted Start Date]
	,[TF Tsk Port Submitted End Date]
	,[TF Tsk Port Submitted Complete Date]
	,[TF Tsk Port Submitted Status]
	,[TF Tsk System Programming Start Date]
	,[TF Tsk System Programming End Date]
	,[TF Tsk System Programming Complete Date]
	,[TF Tsk System Programming Status]
	,[TF Tsk Ready To Test Start Date]
	,[TF Tsk Ready To Test End Date]
	,[TF Tsk Ready To Test Complete Date]
	,[TF Tsk Ready To Test Status]
	,[TF Tsk Port Scheduled Start Date]
	,[TF Tsk Port Scheduled End Date]
	,[TF Tsk Port Scheduled Complete Date]
	,[TF Tsk Port Scheduled Status]
	,[TF Tsk Pre Go Live Testing Start Date]
	,[TF Tsk Pre Go Live Testing End Date]
	,[TF Tsk Pre Go Live Testing Compelte Date]
	,[TF Tsk Pre Go Live Testing Status]
	,[NoteId]
	,[NoteTitle]
	,[NoteModifiedDate]
	,[NoteModifiedBy]
	,[ContractId]
	,[MigrationOrderId]
	,[MigrationOrderStatus]
	,[MigrationCloseOrderStatus]
	,[MigrationOrderDeprovisionDate]
	,[OrderSalesContractId]
	,[PortingOrderDate]
	,[LNPRequestDate]
	,[FOCDate]
	,[TaskfeedBoardType]
	,[TF Tsk Net Readiness Start Date]
	,[TF Tsk Net Readiness End Date]
	,[TF Tsk Net Readiness Complete Date]
	,[TF Tsk Net Readiness Status]
	,[TF_Project_Board_Notes]
	,[TF_External_Sharing]
	,[OppRecordType]
	,[OppType]
	,[OppStage]
	,[OppOwner]
	,[Partner of Record Cloud]
	,[Partner of Record Onsite]
	,[BOSS_Support_Partner__c]
	,[MiCloud_Connect_Business_Model__c]
	,[PartnerDisplayName__c]
	,[PartnerSupportEmailAddress__c]
	,[PartnerSupportInformation__c]
	,[PartnerSupportPhoneNumber__c]
	,[PartnerSupportWebPage__c]
	,[Support_Partner_Enabled__c]
	,[Total #s to LNP]
	,CASE 
		WHEN lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%covid%'
			OR lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%corona%'
			THEN 'COVID-19'
		WHEN TF_MDBoard_Delay_Reason = 'No Matching MiDesign Board'
			THEN 'No Matching MiDesign Board'
		WHEN TF_MDBoard_Delay_Reason IS NULL
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'3rd Party Delay'
				,'Construction/Build required'
				,'Customer not ready'
				,'Customer on leave/vacation'
				,'Customer Timeline not in 30 days'
				,'Customer Timeline not in 60 days'
				,'Kickoff not Scheduled'
				,'Labor Resource needed'
				,'Unable to Reforecast Due Outside Quarter'
				,'Unable to Reforecast Due This Month'
				)
			THEN 'Customer Delay'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Cancellation'
			THEN 'Pending cancellation'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit Install SLA 30-45 days'
				,'Circuit Install SLA 90-120 days'
				)
			THEN 'Circuit Install - Mitel'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit/Fiber Delay - Off Net'
				,'Circuit/Fiber Delay - On Net'
				)
			THEN 'Circuit Install - 3rdParty'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Contract Issue'
				,'Customer in contract with Losing Provider'
				,'Proof of Concept'
				)
			THEN 'Sales Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Customer Unresponsive'
			THEN 'Customer Unresponsive'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'NULL'
				,'Large Call Flow/Contact Center Build'
				,'No Delay'
				,'Phased Install'
				)
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Partner Delay'
				,'Partner Unresponsive'
				)
			THEN 'Partner Dependency'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Sales/Engineering Issue'
			THEN 'R&D Engineering Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Telco/Porting delay'
			THEN 'Telco/Customer Porting Delay'
		ELSE CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255))
		END AS [ScheduleReasonRollup]
	,TF_MDBoard_Mod_Date
	,TF_MDBoard_Delay_Reason collate database_default AS TF_MDBoard_Delay_Reason
	,TF_MDBoard_Notes collate database_default AS TF_MDBoard_Notes
	,TF_MDBoard_Delay_Description collate database_default AS TF_MDBoard_Delay_Description
	,TF_MDBoard_SFDCID
	,TF_MDBoard_Project_Number
	,[Debooked Opportunity] collate database_default AS [Debooked Opportunity]
	,[PRA Score]
	,[Parent Profile] collate database_default AS [Parent Profile]
FROM  --[Tableau].[VwGlobalPipeline_US]
-- temp fix  MW 12282020
 tableau.mVwGlobalPipeline_USv2


UNION ALL

SELECT [Region]
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
	,[Order Sales Opp Number]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,[ForecastDate]
	,[DateSvcLiveActual]
	,[OrderStatus]
	,[OrderType]
	,[MasterOrderType]
	,[BillingStage]
	,[Cluster]
	,[FirstName]
	,[LastName]
	,[OrderId]
	,[OrderDate]
	,[SeatCount]
	,[DateBillingStart]
	,[ServiceId]
	,[DateSvcCreated]
	,[Loc Name]
	,[ServiceStatus]
	,[OrderCreatedBy]
	,[ProductId]
	,[Order PM]
	,[AvgLife Days]
	,[OppCloseDate]
	,[ContractStartDate]
	,[ContractCreateDate]
	,[OpportunityNumber]
	,[VoidDate]
	,[CCClusterName]
	,[CCPlatformName]
	,[SFDC_PM_Role]
	,[PM_Id]
	,[ContractType]
	,[SMRClusterName]
	,[SMRPlatformName]
	,[AccountId]
	,[BOSSPMRole]
	,[ContractProfileAmount]
	,[OppProfileAmount]
	,[ContractNumber]
	,[LocationState]
	,[ServiceCluster]
	,[Master_PMName]
	,[Master_PMId]
	,[ProjectOwnerName]
	,[ProjectDelayReason]
	,[ProjectDelayDescription]
	,[MonthMRRLastInvoiced]
	,[LocationId]
	,[IsMCSSEnabled]
	,[TF_ProjectNumber]
	,[TF_StartDate]
	,[TF_EndDate]
	,[TF_Stage]
	,[TF_PctComplete]
	,[CustomerSegmentByProfileSize]
	,[DS_ActivationStatusRollup]
	,[Staffing_WorkdayName]
	,[Staffing_OrderPM_BOSS]
	,[Staffing_OrderAssignee]
	,[Staffing_OrderAssigneeManager]
	,[Staffing_OrderAssigneeGroup]
	,[Staffing_OrderAssigneeCenter]
	,[Staffing_OrderAssigneeRegion]
	,[Staffing_OrderAssigneeStatus]
	,[Staffing_OrderAssigneePOD]
	,[Staffing_OrderAssigneeStartDate]
	,[Staffing_OrderAssigneeEndDate]
	,[Staffing_CalcPMMRRGoalfortheMonth]
	,[PartnerName]
	,[CSD_MA]
	,[DateServiceClosed]
	,[FirstInvoice]
	,[TF Color Number]
	,[MigrationDate]
	,[DS_ActivationStatusRollup_TEST]
	,[DateBillingValidTo]
	,[DateSvcSetToActive]
	,[isPartnerAccount]
	,[TF Proj Percent Complete]
	,[TF Tsk Project Start Date Start Date]
	,[TF Tsk Project Start Date Sch End Date]
	,[TF Tsk Project Start Date Complete Date]
	,[Account is in SFDC]
	,[Customer Success Manager]
	,[TF Tsk Project Start Date Status]
	,[Opportunity Welcome Contact]
	,[Opportunity NCAM]
	,[Opportunity CAM]
	,[Opportunity C-TAM]
	,[Opportunity ISR]
	,[Opportunity Sub Agent]
	,[Opportunity Territory]
	,[TF Board Sfdc Id]
	,[TF Tsk BRD Sign-Off Start Date]
	,[TF Tsk BRD Sign-Off End Date]
	,[TF Tsk BRD Sign-Off Complete Date]
	,[TF Tsk BRD Sign-Off Status]
	,[TF Tsk Trans To Support Start Date]
	,[TF Tsk Trans To Support Sch End Date]
	,[TF Tsk Trans To Support Complete Date]
	,[TF Tsk Trans To Support Status]
	,[TF Board Last Modified]
	,[ServiceCommitmentDate]
	,[TF Tsk Cust Audit Approval Start Date]
	,[TF Tsk Cust Audit Approval End Date]
	,[TF Tsk Cust Audit Approval Complete Date]
	,[TF Tsk Cust Audit Approval Status]
	,[Accelerated Timeline Initiative Update Date]
	,[Accelerated Timeline Initiative Description]
	,[BusinessTermVersion]
	,[TF Tsk Port In Research Start Date]
	,[TF Tsk Port In Research End Date]
	,[TF Tsk Port In Research Complete Date]
	,[TF Tsk Port In Research Status]
	,[TF Tsk Order New Numbers Start Date]
	,[TF Tsk Order New Numbers End Date]
	,[TF Tsk Order New Numbers Complete Date]
	,[TF Tsk Order New Numbers Status]
	,[TF Tsk Order Hardware Start Date]
	,[TF Tsk Order Hardware End Date]
	,[TF Tsk Order Hardware Complete Date]
	,[TF Tsk Order Hardware Status]
	,[TF Tsk Port Submitted Start Date]
	,[TF Tsk Port Submitted End Date]
	,[TF Tsk Port Submitted Complete Date]
	,[TF Tsk Port Submitted Status]
	,[TF Tsk System Programming Start Date]
	,[TF Tsk System Programming End Date]
	,[TF Tsk System Programming Complete Date]
	,[TF Tsk System Programming Status]
	,[TF Tsk Ready To Test Start Date]
	,[TF Tsk Ready To Test End Date]
	,[TF Tsk Ready To Test Complete Date]
	,[TF Tsk Ready To Test Status]
	,[TF Tsk Port Scheduled Start Date]
	,[TF Tsk Port Scheduled End Date]
	,[TF Tsk Port Scheduled Complete Date]
	,[TF Tsk Port Scheduled Status]
	,[TF Tsk Pre Go Live Testing Start Date]
	,[TF Tsk Pre Go Live Testing End Date]
	,[TF Tsk Pre Go Live Testing Compelte Date]
	,[TF Tsk Pre Go Live Testing Status]
	,[NoteId]
	,[NoteTitle]
	,[NoteModifiedDate]
	,[NoteModifiedBy]
	,[ContractId]
	,[MigrationOrderId]
	,[MigrationOrderStatus]
	,[MigrationCloseOrderStatus]
	,[MigrationOrderDeprovisionDate]
	,[OrderSalesContractId]
	,[PortingOrderDate]
	,[LNPRequestDate]
	,[FOCDate]
	,[TaskfeedBoardType]
	,[TF Tsk Net Readiness Start Date]
	,[TF Tsk Net Readiness End Date]
	,[TF Tsk Net Readiness Complete Date]
	,[TF Tsk Net Readiness Status]
	,[TF_Project_Board_Notes]
	,[TF_External_Sharing]
	,[OppRecordType]
	,[OppType]
	,[OppStage]
	,[OppOwner]
	,[Partner of Record Cloud]
	,[Partner of Record Onsite]
	,[BOSS_Support_Partner__c]
	,[MiCloud_Connect_Business_Model__c]
	,[PartnerDisplayName__c]
	,[PartnerSupportEmailAddress__c]
	,[PartnerSupportInformation__c]
	,[PartnerSupportPhoneNumber__c]
	,[PartnerSupportWebPage__c]
	,[Support_Partner_Enabled__c]
	,[Total #s to LNP]
	,CASE 
		WHEN lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%covid%'
			OR lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%corona%'
			THEN 'COVID-19'
		WHEN TF_MDBoard_Delay_Reason = 'No Matching MiDesign Board'
			THEN 'No Matching MiDesign Board'
		WHEN TF_MDBoard_Delay_Reason IS NULL
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'3rd Party Delay'
				,'Construction/Build required'
				,'Customer not ready'
				,'Customer on leave/vacation'
				,'Customer Timeline not in 30 days'
				,'Customer Timeline not in 60 days'
				,'Kickoff not Scheduled'
				,'Labor Resource needed'
				,'Unable to Reforecast Due Outside Quarter'
				,'Unable to Reforecast Due This Month'
				)
			THEN 'Customer Delay'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Cancellation'
			THEN 'Pending cancellation'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit Install SLA 30-45 days'
				,'Circuit Install SLA 90-120 days'
				)
			THEN 'Circuit Install - Mitel'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit/Fiber Delay - Off Net'
				,'Circuit/Fiber Delay - On Net'
				)
			THEN 'Circuit Install - 3rdParty'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Contract Issue'
				,'Customer in contract with Losing Provider'
				,'Proof of Concept'
				)
			THEN 'Sales Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Customer Unresponsive'
			THEN 'Customer Unresponsive'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'NULL'
				,'Large Call Flow/Contact Center Build'
				,'No Delay'
				,'Phased Install'
				)
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Partner Delay'
				,'Partner Unresponsive'
				)
			THEN 'Partner Dependency'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Sales/Engineering Issue'
			THEN 'R&D Engineering Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Telco/Porting delay'
			THEN 'Telco/Customer Porting Delay'
		ELSE CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255))
		END AS [ScheduleReasonRollup]
	,TF_MDBoard_Mod_Date
	,TF_MDBoard_Delay_Reason collate database_default AS TF_MDBoard_Delay_Reason
	,TF_MDBoard_Notes collate database_default AS TF_MDBoard_Notes
	,TF_MDBoard_Delay_Description collate database_default AS TF_MDBoard_Delay_Description
	,TF_MDBoard_SFDCID
	,TF_MDBoard_Project_Number
	,[Debooked Opportunity] collate database_default AS [Debooked Opportunity]
	,[PRA Score]
	,[Parent Profile] collate database_default AS [Parent Profile]
FROM [Tableau].[mVwGlobalPipeline_AU] (NOLOCK)

UNION ALL

SELECT [Region]
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
	,[Order Sales Opp Number]
	,[Class Group]
	,[Revenue Component]
	,[IsCrossSellProduct]
	,[ForecastDate]
	,[DateSvcLiveActual]
	,[OrderStatus]
	,[OrderType]
	,[MasterOrderType]
	,[BillingStage]
	,[Cluster]
	,[FirstName]
	,[LastName]
	,[OrderId]
	,[OrderDate]
	,[SeatCount]
	,[DateBillingStart]
	,[ServiceId]
	,[DateSvcCreated]
	,[Loc Name]
	,[ServiceStatus]
	,[OrderCreatedBy]
	,[ProductId]
	,[Order PM]
	,[AvgLife Days]
	,[OppCloseDate]
	,[ContractStartDate]
	,[ContractCreateDate]
	,[OpportunityNumber]
	,[VoidDate]
	,[CCClusterName]
	,[CCPlatformName]
	,[SFDC_PM_Role]
	,[PM_Id]
	,[ContractType]
	,[SMRClusterName]
	,[SMRPlatformName]
	,[AccountId]
	,[BOSSPMRole]
	,[ContractProfileAmount]
	,[OppProfileAmount]
	,[ContractNumber]
	,[LocationState]
	,[ServiceCluster]
	,[Master_PMName]
	,[Master_PMId]
	,[ProjectOwnerName]
	,[ProjectDelayReason]
	,[ProjectDelayDescription]
	,[MonthMRRLastInvoiced]
	,[LocationId]
	,[IsMCSSEnabled]
	,[TF_ProjectNumber]
	,[TF_StartDate]
	,[TF_EndDate]
	,[TF_Stage]
	,[TF_PctComplete]
	,[CustomerSegmentByProfileSize]
	,[DS_ActivationStatusRollup]
	,[Staffing_WorkdayName]
	,[Staffing_OrderPM_BOSS]
	,[Staffing_OrderAssignee]
	,[Staffing_OrderAssigneeManager]
	,[Staffing_OrderAssigneeGroup]
	,[Staffing_OrderAssigneeCenter]
	,[Staffing_OrderAssigneeRegion]
	,[Staffing_OrderAssigneeStatus]
	,[Staffing_OrderAssigneePOD]
	,[Staffing_OrderAssigneeStartDate]
	,[Staffing_OrderAssigneeEndDate]
	,[Staffing_CalcPMMRRGoalfortheMonth]
	,[PartnerName]
	,[CSD_MA]
	,[DateServiceClosed]
	,[FirstInvoice]
	,[TF Color Number]
	,[MigrationDate]
	,[DS_ActivationStatusRollup_TEST]
	,[DateBillingValidTo]
	,[DateSvcSetToActive]
	,[isPartnerAccount]
	,[TF Proj Percent Complete]
	,[TF Tsk Project Start Date Start Date]
	,[TF Tsk Project Start Date Sch End Date]
	,[TF Tsk Project Start Date Complete Date]
	,[Account is in SFDC]
	,[Customer Success Manager]
	,[TF Tsk Project Start Date Status]
	,[Opportunity Welcome Contact]
	,[Opportunity NCAM]
	,[Opportunity CAM]
	,[Opportunity C-TAM]
	,[Opportunity ISR]
	,[Opportunity Sub Agent]
	,[Opportunity Territory]
	,[TF Board Sfdc Id]
	,[TF Tsk BRD Sign-Off Start Date]
	,[TF Tsk BRD Sign-Off End Date]
	,[TF Tsk BRD Sign-Off Complete Date]
	,[TF Tsk BRD Sign-Off Status]
	,[TF Tsk Trans To Support Start Date]
	,[TF Tsk Trans To Support Sch End Date]
	,[TF Tsk Trans To Support Complete Date]
	,[TF Tsk Trans To Support Status]
	,[TF Board Last Modified]
	,[ServiceCommitmentDate]
	,[TF Tsk Cust Audit Approval Start Date]
	,[TF Tsk Cust Audit Approval End Date]
	,[TF Tsk Cust Audit Approval Complete Date]
	,[TF Tsk Cust Audit Approval Status]
	,[Accelerated Timeline Initiative Update Date]
	,[Accelerated Timeline Initiative Description]
	,[BusinessTermVersion]
	,[TF Tsk Port In Research Start Date]
	,[TF Tsk Port In Research End Date]
	,[TF Tsk Port In Research Complete Date]
	,[TF Tsk Port In Research Status]
	,[TF Tsk Order New Numbers Start Date]
	,[TF Tsk Order New Numbers End Date]
	,[TF Tsk Order New Numbers Complete Date]
	,[TF Tsk Order New Numbers Status]
	,[TF Tsk Order Hardware Start Date]
	,[TF Tsk Order Hardware End Date]
	,[TF Tsk Order Hardware Complete Date]
	,[TF Tsk Order Hardware Status]
	,[TF Tsk Port Submitted Start Date]
	,[TF Tsk Port Submitted End Date]
	,[TF Tsk Port Submitted Complete Date]
	,[TF Tsk Port Submitted Status]
	,[TF Tsk System Programming Start Date]
	,[TF Tsk System Programming End Date]
	,[TF Tsk System Programming Complete Date]
	,[TF Tsk System Programming Status]
	,[TF Tsk Ready To Test Start Date]
	,[TF Tsk Ready To Test End Date]
	,[TF Tsk Ready To Test Complete Date]
	,[TF Tsk Ready To Test Status]
	,[TF Tsk Port Scheduled Start Date]
	,[TF Tsk Port Scheduled End Date]
	,[TF Tsk Port Scheduled Complete Date]
	,[TF Tsk Port Scheduled Status]
	,[TF Tsk Pre Go Live Testing Start Date]
	,[TF Tsk Pre Go Live Testing End Date]
	,[TF Tsk Pre Go Live Testing Compelte Date]
	,[TF Tsk Pre Go Live Testing Status]
	,[NoteId]
	,[NoteTitle]
	,[NoteModifiedDate]
	,[NoteModifiedBy]
	,[ContractId]
	,[MigrationOrderId]
	,[MigrationOrderStatus]
	,[MigrationCloseOrderStatus]
	,[MigrationOrderDeprovisionDate]
	,[OrderSalesContractId]
	,[PortingOrderDate]
	,[LNPRequestDate]
	,[FOCDate]
	,[TaskfeedBoardType]
	,[TF Tsk Net Readiness Start Date]
	,[TF Tsk Net Readiness End Date]
	,[TF Tsk Net Readiness Complete Date]
	,[TF Tsk Net Readiness Status]
	,[TF_Project_Board_Notes]
	,[TF_External_Sharing]
	,[OppRecordType]
	,[OppType]
	,[OppStage]
	,[OppOwner]
	,[Partner of Record Cloud]
	,[Partner of Record Onsite]
	,[BOSS_Support_Partner__c]
	,[MiCloud_Connect_Business_Model__c]
	,[PartnerDisplayName__c]
	,[PartnerSupportEmailAddress__c]
	,[PartnerSupportInformation__c]
	,[PartnerSupportPhoneNumber__c]
	,[PartnerSupportWebPage__c]
	,[Support_Partner_Enabled__c]
	,[Total #s to LNP]
	,CASE 
		WHEN lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%covid%'
			OR lower(CAST(TF_MDBoard_Delay_Description AS VARCHAR(255))) LIKE '%corona%'
			THEN 'COVID-19'
		WHEN TF_MDBoard_Delay_Reason = 'No Matching MiDesign Board'
			THEN 'No Matching MiDesign Board'
		WHEN TF_MDBoard_Delay_Reason IS NULL
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'3rd Party Delay'
				,'Construction/Build required'
				,'Customer not ready'
				,'Customer on leave/vacation'
				,'Customer Timeline not in 30 days'
				,'Customer Timeline not in 60 days'
				,'Kickoff not Scheduled'
				,'Labor Resource needed'
				,'Unable to Reforecast Due Outside Quarter'
				,'Unable to Reforecast Due This Month'
				)
			THEN 'Customer Delay'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Cancellation'
			THEN 'Pending cancellation'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit Install SLA 30-45 days'
				,'Circuit Install SLA 90-120 days'
				)
			THEN 'Circuit Install - Mitel'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Circuit/Fiber Delay - Off Net'
				,'Circuit/Fiber Delay - On Net'
				)
			THEN 'Circuit Install - 3rdParty'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Contract Issue'
				,'Customer in contract with Losing Provider'
				,'Proof of Concept'
				)
			THEN 'Sales Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Customer Unresponsive'
			THEN 'Customer Unresponsive'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'NULL'
				,'Large Call Flow/Contact Center Build'
				,'No Delay'
				,'Phased Install'
				)
			THEN 'In Progress'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) IN (
				'Partner Delay'
				,'Partner Unresponsive'
				)
			THEN 'Partner Dependency'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Sales/Engineering Issue'
			THEN 'R&D Engineering Issue'
		WHEN CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255)) = 'Telco/Porting delay'
			THEN 'Telco/Customer Porting Delay'
		ELSE CAST(TF_MDBoard_Delay_Reason AS VARCHAR(255))
		END AS [ScheduleReasonRollup]
	,TF_MDBoard_Mod_Date
	,TF_MDBoard_Delay_Reason collate database_default AS TF_MDBoard_Delay_Reason
	,TF_MDBoard_Notes collate database_default AS TF_MDBoard_Notes
	,TF_MDBoard_Delay_Description collate database_default AS TF_MDBoard_Delay_Description
	,TF_MDBoard_SFDCID
	,TF_MDBoard_Project_Number
	,[Debooked Opportunity] collate database_default AS [Debooked Opportunity]
	,[PRA Score]
	,[Parent Profile] collate database_default AS [Parent Profile]
FROM [Tableau].[mVwGlobalPipeline_EU] (NOLOCK)
