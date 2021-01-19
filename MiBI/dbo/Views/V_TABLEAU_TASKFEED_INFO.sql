






 CREATE view [dbo].[V_TABLEAU_TASKFEED_INFO] as 
 -- MW 10302019 This is pulled into the cloud forcast datasource
 SELECT
	 a.taskfeed1__Opportunity__c  as OpportunityId
    ,a.Project_Number__c	as 	TaskfeedProjectNumber
	,u.Name as TaskfeedPM
	,u.Manager as TaskfeedPMManager
	--,a.taskfeed1__Color__c as [TF Color Number]
	,row_number() over (partition by a.taskfeed1__Opportunity__c order by a.Created desc) rn
 
FROM
	SFDC_TASKFEED_BOARD a (nolock) inner join
	--PORTUNITY o (nolock)  on a.taskfeed1__Opportunity__c = o.OpportunityID inner join
	V_TABLEAU_SFDC_USER u  (nolock) on a.OwnerId = u.Id
where isDeleted = 0 
	 and taskfeed1__Type__c	= 'Project'
