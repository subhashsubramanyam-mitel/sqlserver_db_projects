





CREATE view [dbo].[V_TABLEAU_TASKFEED_TASK] as 
--MW 10212019 View for Taskfeed tableau reporting
--MW 04282020 Making unique task name

with CTE as (
select 
 	Id	as	SfdcTaskId
,	Name	as	TaskName
,	taskfeed1__Pc_Subtasks_Complete__c	as	PctSubtasksComplete
--,	taskfeed1__Account__c	as	AccountId
,	taskfeed1__Active__c	as	Active
,	taskfeed1__Active_Date__c	as	ActiveDate
-- ? ,	taskfeed1__Active_Duration_Days__c	as	ActiveDurationDays
,	taskfeed1__Blocked__c	as	Blocked
,	taskfeed1__Board__c	as	BoardId
,	taskfeed1__Board_Type__c	as	BoardType
,	Case__c	as	[Case]
,	taskfeed1__Category__c	as	Category
,	taskfeed1__Checklist_Items__c	as	ChecklistItems
,	taskfeed1__Checklist_Items_Template__c	as	ChecklistItemsTemplate
,	taskfeed1__Complete__c	as	Complete
,	taskfeed1__Complete_Date__c	as	CompleteDate
,	taskfeed1__Completed_Checklist_Items__c	as	CompletedChecklistItems
,	taskfeed1__Contributor_Aliases__c	as	ContributorAliases
,	taskfeed1__Contributor_Ids__c	as	ContributorIds
,	taskfeed1__Contributor_Manager_Ids__c	as	ContributorManagerIds
,	taskfeed1__Contributor_Role_Initials__c	as	ContributorRoleInitials
,	taskfeed1__Contributor_Role_Placeholders_Template__c	as	ContributorRolePlaceholdersTemplate
,	taskfeed1__Contributor_Roles__c	as	ContributorRoles
,	taskfeed1__Contributors__c	as	Contributors
,	taskfeed1__Contributor_Unassigned_Roles__c	as	ContributorUnassignedRoles
,	taskfeed1__Created_By_Me__c	as	CreatedByMe
,	taskfeed1__Days_Remaining__c	as	DaysRemaining
,	taskfeed1__Decay__c	as	Decay
,	taskfeed1__Decay_Warning_Amber__c	as	DecayWarningAmber
,	taskfeed1__Decay_Warning_Red__c	as	DecayWarningRed
,	taskfeed1__Detail__c	as	Detail
,	taskfeed1__Due_Date__c	as	DueDate
,	taskfeed1__Duration__c	as	DurationDays
,	taskfeed1__End_Date__c	as	EndDate
,	taskfeed1__End_Date_Baseline__c	as	EndDateBaseline
,	taskfeed1__End_Variance__c	as	EndVariance
,	taskfeed1__Estimated_Hours__c	as	EstimatedHours
,	taskfeed1__Internal__c	as	InternalOnly
,	taskfeed1__Is_Parent__c	as	IsParent
,	taskfeed1__Is_Subtask__c	as	IsSubtask
,	taskfeed1__Lead_Lag__c	as	LeadLagDays
,	taskfeed1__Lock_Due_Date__c	as	LockDueDate
,	taskfeed1__Move_Due_Date_with_End_Date__c	as	MoveDueDatewithEndDate
,	taskfeed1__My_Task__c	as	MyTask
,	taskfeed1__My_Teams_Task__c	as	MyTeamsTask
,	taskfeed1__Completed_Subtasks__c	as	NumberofCompletedSubtasks
,	taskfeed1__Subtasks__c	as	NumberofSubtasks
,	taskfeed1__Open__c	as	[Open]
,	taskfeed1__Opportunity__c	as	Opportunity
,	taskfeed1__Order__c	as	[Order]
,	taskfeed1__Board_Order__c	as	OrderBoard
,	taskfeed1__Owner__c	as	OwnerId
,	taskfeed1__Parent_Reference__c	as	ParentReference
,	taskfeed1__Parent__c	as	ParentTask
,	taskfeed1__Predecessor_Reference__c	as	PredecessorReference
,	taskfeed1__Predecessor_Task__c	as	PredecessorTask
,	taskfeed1__Predecessor_Task_Complete__c	as	PredecessorTaskComplete
,	taskfeed1__Ready__c	as	Ready
,	taskfeed1__Ready_Date__c	as	ReadyDate
,	taskfeed1__Reference2__c	as	Reference2
,	taskfeed1__Remaining_Hours__c	as	RemainingHours
,	taskfeed1__Repeated_Task__c	as	RepeatedTask
,	taskfeed1__Set_Baseline__c	as	SetBaseline
,	taskfeed1__Stage__c	as	Stage
,	taskfeed1__Start_Date__c	as	StartDate
,	taskfeed1__Start_DateTime__c	as	StartDateTimeDeprecated
,	taskfeed1__Start_Date_Baseline__c	as	StartDateBaseline
,	taskfeed1__Start_Variance__c	as	StartVariance
,	taskfeed1__Recorded_Hours__c	as	TimeSpentHours
,	taskfeed1__Total_Feed_Posts__c	as	TotalFeedPosts
,	taskfeed1__Version__c	as	Version
,	taskfeed1__Version_Date__c	as	VersionDate
,   ListStatus
,	row_number() over (partition by taskfeed1__Board__c+Name order by CreatedDate desc) rn
from    
	SFDC_TASKFEED_TASK (nolock)
where isDeleted = 0

) 
select * from CTE where rn =1
 
 

