



CREATE view [dbo].[V_MCSS_TXN_SURVEY] as
-- for Tableau MCSS DSx MW 12102019
select b.ID as CaseId, 
		a.ResponseReceivedDate,
		convert(float,a.PrimaryScore)	 as 	CaseOverallSatisfaction	,
		convert(float,
					CASE WHEN upper(a.FirstContactResolution) = 'YES' then 1 else 0 end)	 as 	CaseFirstEngagement	,
		 a.CustomerEffort 	 as 	OnlineResourcesAttempt	,
		a.GF_ContactMitel	 as 	ContactMitel	,
		a.GF_OnlineResources	 as 	OnlineResources	,
		convert(float,a.Satisfaction_with_Professionalism__c)	 as 	CourtesyAndProfessionalism	,
		convert(float,a.Satisfaction_with_Troubleshooting__c)	 as 	AbilityToTroubleshoot	,
		convert(float,a.Issues_Resolution_Satisfaction__c)	 as 	EffectivenessOfSolution	,
		convert(float,a.Satisfaction_with_Time_to_Answer__c)	 as 	TimeToComplete	,
		a.Improvement_Suggestion__c	 as 	SupportExperienceImprovement	,
		a.GF_OutstandingIssue	 as 	OutstandingIssue	,
		a.PrimaryComment	 as 	OpenIssue	 
		,a.CreatedDate as SurveyCreateDate

FROM
	Surveys a (nolock) left outer join
	Cases b (nolock) on a.CaseNumber = b.CaseNumber
where a.CreatedDate > '2019-11-01'
and a.DataCollectionName in ( 'Case Transactional Survey' , 'Tech Support Survey')   
