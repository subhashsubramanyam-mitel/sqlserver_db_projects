





















/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_SFDC_TASKFEED_INFO] as
-- MW 11182019 custom View sourced by Boss Pipeline.

SELECT        
 'MD' as Type -- MiDesign
 ,a.BossLocationId 
,a.DelayReason
,a.DelayReasonDetails
,a.ProjectNumber as TF_ProjectNumber
,a.StartDate as TF_StartDate
,a.EndDate as TF_EndDate
,a.Stage as TF_Stage
,a.PctComplete as TF_PctComplete
,b.Name as TaskFeedProjectManager
,a.OpportunityId
,o.OpportunityNumber
,a.[TF Color Number]
,sd.[TF Tsk Project Start Date Start Date]
,sd.[TF Tsk Project Start Date Sch End Date]
,sd.[TF Tsk Project Start Date Complete Date]
,sd.ListStatus as [TF Tsk Project Start Date Status]
,a.BoardSfdcId as [TF Board Sfdc Id]
,bs.[TF Tsk BRD Sign-Off Start Date]
,bs.[TF Tsk BRD Sign-Off End Date]
,bs.[TF Tsk BRD Sign-Off Complete Date]
,bs.[TF Tsk BRD Sign-Off Status]

,ts.[TF Tsk Trans To Support Start Date]
,ts.[TF Tsk Trans To Support Sch End Date]
,ts.[TF Tsk Trans To Support Complete Date]
,ts.[TF Tsk Trans To Support Status]
,a.LastModifiedDate as [TF Board Last Modified]


,ca.[TF Tsk Cust Audit Approval Start Date]
,ca.[TF Tsk Cust Audit Approval End Date]
,ca.[TF Tsk Cust Audit Approval Complete Date]
,ca.[TF Tsk Cust Audit Approval Status]
,atl.DateRecorded as [Accelerated Timeline Initiative Update Date]
,atl.Description as [Accelerated Timeline Initiative Description]

	,[TF Tsk Port In Research Start Date]
	, [TF Tsk Port In Research End Date]
	, [TF Tsk Port In Research Complete Date]
	,[TF Tsk Port In Research Status]
	,[TF Tsk Order New Numbers Start Date]
	,[TF Tsk Order New Numbers End Date]
	, [TF Tsk Order New Numbers Complete Date]
	,[TF Tsk Order New Numbers Status]
	,[TF Tsk Order Hardware Start Date]
	, [TF Tsk Order Hardware End Date]
	,[TF Tsk Order Hardware Complete Date]
	, [TF Tsk Order Hardware Status]
	,[TF Tsk Port Submitted Start Date]
	,[TF Tsk Port Submitted End Date]
	, [TF Tsk Port Submitted Complete Date]
	,[TF Tsk Port Submitted Status]
	,[TF Tsk System Programming Start Date]
	, [TF Tsk System Programming End Date]
	,[TF Tsk System Programming Complete Date]
	, [TF Tsk System Programming Status]
	,[TF Tsk Ready To Test Start Date]
	, [TF Tsk Ready To Test End Date]
	,[TF Tsk Ready To Test Complete Date]
	, [TF Tsk Ready To Test Status]
	,[TF Tsk Port Scheduled Start Date]
	, [TF Tsk Port Scheduled End Date]
	,[TF Tsk Port Scheduled Complete Date]
	, [TF Tsk Port Scheduled Status]
	,[TF Tsk Pre Go Live Testing Start Date]
	,[TF Tsk Pre Go Live Testing End Date]
	, [TF Tsk Pre Go Live Testing Compelte Date]
	,[TF Tsk Pre Go Live Testing Status]
	,a.[Type] as  TaskfeedBoardType

	,[TF Tsk Net Readiness Start Date]
	,[TF Tsk Net Readiness End Date]
	,[TF Tsk Net Readiness Complete Date]
	,[TF Tsk Net Readiness Status]
	, substring(TF_Project_Board_Notes, 0,199) as TF_Project_Board_Notes
	, TF_External_Sharing
	,b.Email as TaskFeedProjectManagerEmail
	,b.Phone as TaskFeedProjectManagerPhone
	,a.PRAScore as [PRA Score]

,row_number() over (partition by a.OpportunityId order by a.CreateDate desc) rn
FROM            V_TABLEAU_TASKFEED_BOARD AS a 
			inner join OPPORTUNITY o on a.OpportunityId = o.OpportunityID
            left outer JOIN   Users AS b ON a.OwnerId = b.ID
			left join (
				SELECT  
						   [BoardId]
						  ,StartDate [TF Tsk Project Start Date Start Date]
						  ,EndDate   [TF Tsk Project Start Date Sch End Date]
						  ,CompleteDate [TF Tsk Project Start Date Complete Date]
						  ,ListStatus
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName = 'Project Start Date'
						  ) sd on a.BoardSfdcId = sd.BoardId
				left join (
				SELECT  
						   [BoardId]
						  ,StartDate [TF Tsk BRD Sign-Off Start Date]
						  ,EndDate   [TF Tsk BRD Sign-Off End Date]
						  ,CompleteDate [TF Tsk BRD Sign-Off Complete Date]
						  ,ListStatus as [TF Tsk BRD Sign-Off Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName = 'BRD Sign-Off'
						  ) bs on a.BoardSfdcId = bs.BoardId
				left join (SELECT    
						   [BoardId]
						  ,StartDate [TF Tsk Trans To Support Start Date]
						  ,EndDate   [TF Tsk Trans To Support Sch End Date]
						  ,CompleteDate [TF Tsk Trans To Support Complete Date]
						  ,ListStatus [TF Tsk Trans To Support Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Transition to Support and CSM' , 'Transition to Support/CSM', 'Transition to Support')
					  ) ts on a.BoardSfdcId = ts.BoardId
				left join (SELECT    
						   [BoardId]
						  ,StartDate [TF Tsk Cust Audit Approval Start Date]
						  ,EndDate   [TF Tsk Cust Audit Approval End Date]
						  ,CompleteDate [TF Tsk Cust Audit Approval Complete Date]
						  ,ListStatus [TF Tsk Cust Audit Approval Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  = ('Customer Approval of Account Audit')
					  ) ca on a.BoardSfdcId = ca.BoardId  left join
					(
					select 
							 b.taskfeed1__Board__c as BoardId
							,a.taskfeed1__DateTime_Recorded__c as DateRecorded
							,a.taskfeed1__Description__c as Description
							,row_number() over (partition by taskfeed1__Task__c order by a.taskfeed1__DateTime_Recorded__c  desc ) rn
					from
						SFDC_TASKFEED_TIME a (nolock)  inner join
						SFDC_TASKFEED_TASK b  (nolock)  on a.taskfeed1__Task__c = b.Id and b.Name = 'Accelerated Timeline Initiative'
					) atl on a.BoardSfdcId = atl.BoardId and atl.rn = 1 left join
				 
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port In Research Start Date]
						  ,EndDate     [TF Tsk Port In Research End Date]
						  ,CompleteDate   [TF Tsk Port In Research Complete Date]
						  ,ListStatus    [TF Tsk Port In Research Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in
				(	'Port In Research' , 'LNP In Research')

) t1 on    a.BoardSfdcId = t1.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Order New Numbers Start Date]
						  ,EndDate    [TF Tsk Order New Numbers End Date]
						  ,CompleteDate   [TF Tsk Order New Numbers Complete Date]
						  ,ListStatus    [TF Tsk Order New Numbers Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Order New Numbers'  
)  t1a on    a.BoardSfdcId = t1a.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Order Hardware Start Date]
						  ,EndDate   [TF Tsk Order Hardware End Date]
						  ,CompleteDate  [TF Tsk Order Hardware Complete Date]
						  ,ListStatus   [TF Tsk Order Hardware Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Order Hardware'  

)  t2 on    a.BoardSfdcId = t2.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port Submitted Start Date]
						  ,EndDate    [TF Tsk Port Submitted End Date]
						  ,CompleteDate   [TF Tsk Port Submitted Complete Date]
						  ,ListStatus    [TF Tsk Port Submitted Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Port Submitted'  

)  t3 on    a.BoardSfdcId = t3.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk System Programming Start Date]
						  ,EndDate   [TF Tsk System Programming End Date]
						  ,CompleteDate  [TF Tsk System Programming Complete Date]
						  ,ListStatus   [TF Tsk System Programming Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='System Programming'  

) t4 on    a.BoardSfdcId = t4.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Net Readiness Start Date]
						  ,EndDate  [TF Tsk Net Readiness End Date]
						  ,CompleteDate  [TF Tsk Net Readiness Complete Date]
						  ,ListStatus   [TF Tsk Net Readiness Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName in ('Network Readiness Review' , 'Network Prep') 

)  t5 on    a.BoardSfdcId = t5.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Ready To Test Start Date]
						  ,EndDate   [TF Tsk Ready To Test End Date]
						  ,CompleteDate  [TF Tsk Ready To Test Complete Date]
						  ,ListStatus   [TF Tsk Ready To Test Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName in ('Ready to Test', 'Ready to test' , 'Ready to Test Notice Sent')

) t6 on    a.BoardSfdcId = t6.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port Scheduled Start Date]
						  ,EndDate   [TF Tsk Port Scheduled End Date]
						  ,CompleteDate  [TF Tsk Port Scheduled Complete Date]
						  ,ListStatus   [TF Tsk Port Scheduled Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Port Scheduled'  

) t7 on    a.BoardSfdcId = t7.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Pre Go Live Testing Start Date]
						  ,EndDate  [TF Tsk Pre Go Live Testing End Date]
						  ,CompleteDate [TF Tsk Pre Go Live Testing Compelte Date]
						  ,ListStatus  [TF Tsk Pre Go Live Testing Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Pre-Go Live Testing' , 'CSE Follow Up', 'CSE Follow up')
) t8 on    a.BoardSfdcId = t8.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Go Live Start Date]
						  ,EndDate  [TF Tsk Go Live End Date]
						  ,CompleteDate [TF Tsk Go Live Complete Date]
						  ,ListStatus  [TF Tsk Go Live Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Go Live and Service Activated', 'GO LIVE/Services Activated')
) t9 on    a.BoardSfdcId = t9.BoardId  							 
where 
	  a.OpportunityId is not null and 
	  a.Type = 'Project' -- MiDesign
 union all 
SELECT        
 'Location' as Type
,a.BossLocationId 
,a.DelayReason
,a.DelayReasonDetails
,a.ProjectNumber as TF_ProjectNumber
,a.StartDate as TF_StartDate
,a.EndDate as TF_EndDate
,a.Stage as TF_Stage
,a.PctComplete as TF_PctComplete
,b.Name as TaskFeedProjectManager
,a.OpportunityId
,o.OpportunityNumber
,a.[TF Color Number]
,sd.[TF Tsk Project Start Date Start Date]
,sd.[TF Tsk Project Start Date Sch End Date]
,sd.[TF Tsk Project Start Date Complete Date]
,sd.ListStatus as [TF Tsk Project Start Date Status]
,a.BoardSfdcId as [TF Board Sfdc Id]
,bs.[TF Tsk BRD Sign-Off Start Date]
,bs.[TF Tsk BRD Sign-Off End Date]
,bs.[TF Tsk BRD Sign-Off Complete Date]
,bs.[TF Tsk BRD Sign-Off Status]

,ts.[TF Tsk Trans To Support Start Date]
,ts.[TF Tsk Trans To Support Sch End Date]
,ts.[TF Tsk Trans To Support Complete Date]
,ts.[TF Tsk Trans To Support Status]
,a.LastModifiedDate as [TF Board Last Modified]


,ca.[TF Tsk Cust Audit Approval Start Date]
,ca.[TF Tsk Cust Audit Approval End Date]
,ca.[TF Tsk Cust Audit Approval Complete Date]
,ca.[TF Tsk Cust Audit Approval Status]
,atl.DateRecorded as [Accelerated Timeline Initiative Update Date]
,atl.Description as [Accelerated Timeline Initiative Description]

	,[TF Tsk Port In Research Start Date]
	, [TF Tsk Port In Research End Date]
	, [TF Tsk Port In Research Complete Date]
	,[TF Tsk Port In Research Status]
	,[TF Tsk Order New Numbers Start Date]
	,[TF Tsk Order New Numbers End Date]
	, [TF Tsk Order New Numbers Complete Date]
	,[TF Tsk Order New Numbers Status]
	,[TF Tsk Order Hardware Start Date]
	, [TF Tsk Order Hardware End Date]
	,[TF Tsk Order Hardware Complete Date]
	, [TF Tsk Order Hardware Status]
	,[TF Tsk Port Submitted Start Date]
	,[TF Tsk Port Submitted End Date]
	, [TF Tsk Port Submitted Complete Date]
	,[TF Tsk Port Submitted Status]
	,[TF Tsk System Programming Start Date]
	, [TF Tsk System Programming End Date]
	,[TF Tsk System Programming Complete Date]
	, [TF Tsk System Programming Status]
	,[TF Tsk Ready To Test Start Date]
	, [TF Tsk Ready To Test End Date]
	,[TF Tsk Ready To Test Complete Date]
	, [TF Tsk Ready To Test Status]
	,[TF Tsk Port Scheduled Start Date]
	, [TF Tsk Port Scheduled End Date]
	,[TF Tsk Port Scheduled Complete Date]
	, [TF Tsk Port Scheduled Status]
	,[TF Tsk Pre Go Live Testing Start Date]
	,[TF Tsk Pre Go Live Testing End Date]
	, [TF Tsk Pre Go Live Testing Compelte Date]
	,[TF Tsk Pre Go Live Testing Status]
	,a.[Type] as TaskfeedBoardType

	,[TF Tsk Net Readiness Start Date]
	,[TF Tsk Net Readiness End Date]
	,[TF Tsk Net Readiness Complete Date]
	,[TF Tsk Net Readiness Status]

	, substring(TF_Project_Board_Notes, 0,199) as TF_Project_Board_Notes
	, TF_External_Sharing

		,b.Email as TaskFeedProjectManagerEmail
	,b.Phone as TaskFeedProjectManagerPhone
	,a.PRAScore as [PRA Score]
,row_number() over (partition by a.BossLocationId order by a.CreateDate desc) rn
FROM            V_TABLEAU_TASKFEED_BOARD AS a 
       			inner join OPPORTUNITY o on a.OpportunityId = o.OpportunityID
			    left outer JOIN   Users AS b ON a.OwnerId = b.ID
				left join (
				SELECT  
						   [BoardId]
						  ,StartDate [TF Tsk Project Start Date Start Date]
						  ,EndDate   [TF Tsk Project Start Date Sch End Date]
						  ,CompleteDate [TF Tsk Project Start Date Complete Date]
						  ,ListStatus
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName = 'Project Start Date'
						  ) sd on a.BoardSfdcId = sd.BoardId
				left join (
				SELECT  
						   [BoardId]
						  ,StartDate [TF Tsk BRD Sign-Off Start Date]
						  ,EndDate   [TF Tsk BRD Sign-Off End Date]
						  ,CompleteDate [TF Tsk BRD Sign-Off Complete Date]
						  ,ListStatus as [TF Tsk BRD Sign-Off Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName = 'BRD Sign-Off'
						  ) bs on a.BoardSfdcId = bs.BoardId
				left join (SELECT    
						   [BoardId]
						  ,StartDate [TF Tsk Trans To Support Start Date]
						  ,EndDate   [TF Tsk Trans To Support Sch End Date]
						  ,CompleteDate [TF Tsk Trans To Support Complete Date]
						  ,ListStatus [TF Tsk Trans To Support Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Transition to Support and CSM' , 'Transition to Support/CSM', 'Transition to Support')
					  ) ts on a.BoardSfdcId = ts.BoardId
				left join (SELECT    
						   [BoardId]
						  ,StartDate [TF Tsk Cust Audit Approval Start Date]
						  ,EndDate   [TF Tsk Cust Audit Approval End Date]
						  ,CompleteDate [TF Tsk Cust Audit Approval Complete Date]
						  ,ListStatus [TF Tsk Cust Audit Approval Status]
					  FROM [dbo].[V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  = ('Customer Approval of Account Audit')
					  ) ca on a.BoardSfdcId = ca.BoardId  left join
					(
					select 
							 b.taskfeed1__Board__c as BoardId
							,a.taskfeed1__DateTime_Recorded__c as DateRecorded
							,a.taskfeed1__Description__c as Description
							,row_number() over (partition by taskfeed1__Task__c order by a.taskfeed1__DateTime_Recorded__c  desc ) rn
					from
						SFDC_TASKFEED_TIME a (nolock)  inner join
						SFDC_TASKFEED_TASK b  (nolock)  on a.taskfeed1__Task__c = b.Id and b.Name = 'Accelerated Timeline Initiative'
					) atl on a.BoardSfdcId = atl.BoardId and atl.rn = 1 left join
				 
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port In Research Start Date]
						  ,EndDate     [TF Tsk Port In Research End Date]
						  ,CompleteDate   [TF Tsk Port In Research Complete Date]
						  ,ListStatus    [TF Tsk Port In Research Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in
				(	'Port In Research' , 'LNP In Research')

) t1 on    a.BoardSfdcId = t1.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Order New Numbers Start Date]
						  ,EndDate    [TF Tsk Order New Numbers End Date]
						  ,CompleteDate   [TF Tsk Order New Numbers Complete Date]
						  ,ListStatus    [TF Tsk Order New Numbers Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Order New Numbers'  
)  t1a on    a.BoardSfdcId = t1a.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Order Hardware Start Date]
						  ,EndDate   [TF Tsk Order Hardware End Date]
						  ,CompleteDate  [TF Tsk Order Hardware Complete Date]
						  ,ListStatus   [TF Tsk Order Hardware Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Order Hardware'  

)  t2 on    a.BoardSfdcId = t2.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port Submitted Start Date]
						  ,EndDate    [TF Tsk Port Submitted End Date]
						  ,CompleteDate   [TF Tsk Port Submitted Complete Date]
						  ,ListStatus    [TF Tsk Port Submitted Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Port Submitted'  

)  t3 on    a.BoardSfdcId = t3.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk System Programming Start Date]
						  ,EndDate   [TF Tsk System Programming End Date]
						  ,CompleteDate  [TF Tsk System Programming Complete Date]
						  ,ListStatus   [TF Tsk System Programming Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='System Programming'  

) t4 on    a.BoardSfdcId = t4.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Net Readiness Start Date]
						  ,EndDate  [TF Tsk Net Readiness End Date]
						  ,CompleteDate  [TF Tsk Net Readiness Complete Date]
						  ,ListStatus   [TF Tsk Net Readiness Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName in ('Network Readiness Review' , 'Network Prep') 

)  t5 on    a.BoardSfdcId = t5.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Ready To Test Start Date]
						  ,EndDate   [TF Tsk Ready To Test End Date]
						  ,CompleteDate  [TF Tsk Ready To Test Complete Date]
						  ,ListStatus   [TF Tsk Ready To Test Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName in ('Ready to Test', 'Ready to test' , 'Ready to Test Notice Sent')

) t6 on    a.BoardSfdcId = t6.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Port Scheduled Start Date]
						  ,EndDate   [TF Tsk Port Scheduled End Date]
						  ,CompleteDate  [TF Tsk Port Scheduled Complete Date]
						  ,ListStatus   [TF Tsk Port Scheduled Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  ='Port Scheduled'  

) t7 on    a.BoardSfdcId = t7.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Pre Go Live Testing Start Date]
						  ,EndDate  [TF Tsk Pre Go Live Testing End Date]
						  ,CompleteDate [TF Tsk Pre Go Live Testing Compelte Date]
						  ,ListStatus  [TF Tsk Pre Go Live Testing Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Pre-Go Live Testing' , 'CSE Follow Up', 'CSE Follow up')
) t8 on    a.BoardSfdcId = t8.BoardId  left join
(
SELECT    
						   [BoardId]
						  ,StartDate  [TF Tsk Go Live Start Date]
						  ,EndDate  [TF Tsk Go Live End Date]
						  ,CompleteDate [TF Tsk Go Live Complete Date]
						  ,ListStatus  [TF Tsk Go Live Status]
					  FROM  [V_TABLEAU_TASKFEED_TASK] (nolock)
					where TaskName  in ('Go Live and Service Activated', 'GO LIVE/Services Activated')
) t9 on    a.BoardSfdcId = t9.BoardId  
where 
	  a.BossLocationId is not null and 
	  a.Type = 'New Location'  
