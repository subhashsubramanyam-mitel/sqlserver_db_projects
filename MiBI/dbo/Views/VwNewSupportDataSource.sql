/*
SELECT * FROM dbo.VwNewSupportDataSource 

*/
CREATE VIEW dbo.VwNewSupportDataSource
AS
SELECT --Cases
	C.ID AS CaseId
	,C.[Status]
	,C.[CaseOwnerRole]
	,C.[CaseOwner]
	,C.[CustomerType]
	,C.[Region] AS [CaseRegion]
	,C.[CaseNumber]
	--, C.[FCR] (Calculated Column)
	,C.[CaseOrigin]
	,C.[smx_case_no_of_days]
	,C.[CaseReason]
	,C.[SubReason]
	,C.[Feature]
	,C.[SubFeature]
	,C.[ATEscalation]
	,C.[AtRiskIndicator]
	,C.[AtRisk]
	,C.[AccountID]
	,C.[AccountName]
	,C.[CustomerPlatform]
	,C.[Instance]
	,C.[Subject]
	,C.[Priority]
	,C.[RootCause]
	,C.[Resolution]
	,C.[RelatedIncident]
	,C.[Theater]
	,C.[RequestType]
	,C.[RequestSubType]
	,C.[RFOAvailable]
	,C.[RFORequested]
	,C.[OwnerId]
	,C.[EngStatus]
	,C.[DateEscalated]
	,C.[AccountTeam]
	,C.[CreatedBy] AS CaseCreatedBy
	,C.[CreatedDate] AS CaseCreatedDate
	,C.[ClosedDate] AS CaseClosedDate
	,C.[LastModifiedDate] AS CaseLastModifiedDate
	,C.CaseContactVARECertified__c
	-- Customers
	--,Cu.SfdcId AS AccountID
	,Cu.[NAME] AS CustomerName
	,Cu.Region AS CustomerRegion
	,Cu.AccountTeam AS CustomerAccountTeam
	,Cu.Theater AS CustomerTheater
	,Cu.Created AS CustomerCreatedDate
	--,Cu.CustomerType
	--,Cu.[Platform] AS CustomerPlatform
	,Cu.[Status] AS CustomerAccountStatus
	,Cu.[Type]
	,Cu.[AtRiskNow]
	--,Cu.Instance
	,Cu.ActiveMRR_Boss
	-- CaseMilestone
	,Cm.Id AS CaseMileStoneId
	--,Cm.CaseId 
	,Cm.Completed AS CaseMileStoneCompleted
	,Cm.CompletionDate AS CaseMileStoneCompletionDate
	,Cm.CreatedDate AS CaseMilestoneCreatedDate
	,Cm.LastModifiedDate AS CaseMilestoneLastModifiedDate
	,Cm.MilestoneName
	,Cm.TargetDate AS CaseMileStoneTargetDate
	,Cm.TimeRemaining AS CaseMilestoneTimeRemaining
	,Cm.Violation AS CaseMilestoneViolation
	-- Case Owner
	--,Co.[ID] As CaseOwnerId
	,Co.[Active]
	,Co.[ContactId]
	,Co.[CreatedDate] AS CaseOwnerCreatedDate
	,Co.[Department]
	,Co.[Email]
	,Co.[FirstName]
	,Co.[LastName]
	,Co.[LastModifiedDate] AS CaseOwnerLastModifiedDate
	,Co.[Name]
	,Co.[Title]
	,Co.[Username]
	,Co.[RoleName]
	,Co.[AccountId]
	,Co.[AccountName] AS CaseOwnerAccountName
	,Co.[ProfileId]
	,Co.[ProfileName]
	,Co.[Phone]
	,Co.[ManagerId]
	,Co.[Extension]
	--Coaching
	,Cc.[Id] AS CoachingId
	,Cc.[FinalScore]
	,Cc.[Overall_QA_Score__c]
	,Cc.[Overall_QA_Score2__c]
	,Cc.[Total_Process_Score__c]
	,Cc.[Total_Product_Technical_Score__c]
	,Cc.[Name] AS CoachingName
	,Cc.[Team__c]
	,Cc.[Case_Number__c]
	,Cc.CaseOwner AS CoachingCaseOwner
	,Cc.[Evaluated_By__c]
	,Cc.[Evaluation_Date__c]
	,Cc.[Total_Communication_Score__c]
	,Cc.[Total_Communication_Score2__c]
	,Cc.[Total_Process_Score2__c]
	,Cc.[Total_Product_Technical_Score2__c]
	,Cc.[Total_Product_Score__c]
	,Cc.[FinalScoreT1T2]
	,Cc.[Areas_of_Improvement__c]
	,Cc.[Areas_of_Excellence__c]
	,Cc.[Customer_Experience_Score__c]
	,Cc.[Customer_Experience_Score1__c]
	-- Surveys
	,S.ID AS SurveyID
	,S.CaseNumber AS SurveysCaseNumber
	,S.PrimaryScore AS SurveysPrimaryScore
	,S.DataCollectionName AS SurveysDataCollectionName
	,S.Source AS SurveysSource
	,S.RepEffectiveness
	,S.RepProfessionalism
	,S.RepResponsiveness
	,S.RepSpeedToRespond
	,S.RepTechKnowledge
	,S.Satisfaction_with_Professionalism__c
	,S.Satisfaction_with_Resolution__c
	,S.Satisfaction_with_Time_to_Answer__c
	,S.Satisfaction_with_Time_to_Resolve__c
	,S.Satisfaction_with_Troubleshooting__c
	,S.[CreatedDate] AS SurveysCreatedDate
	,S.ResponseReceivedDate As SurveysResponseReceivedDate
FROM dbo.Cases C(NOLOCK)
LEFT OUTER JOIN dbo.CUSTOMERS Cu(NOLOCK) ON Cu.[SfdcId] = C.[AccountID]
LEFT OUTER JOIN [dbo].[PartnerLookup] P(NOLOCK) ON P.[SfdcId] = Cu.[SfdcId]
LEFT OUTER JOIN dbo.CaseMilestone Cm(NOLOCK) ON Cm.[CaseId] = C.ID
	AND Cm.CreatedDate >= '2020-01-01'
LEFT OUTER JOIN dbo.Users Co(NOLOCK) ON Co.ID = C.[OwnerId]
	AND Co.CreatedDate >= '2020-01-01'
LEFT OUTER JOIN dbo.Coaching Cc(NOLOCK) ON Cc.[Case_Number__c] = C.CaseNumber
	AND Cc.Created >= '2020-01-01'
LEFT OUTER JOIN dbo.Surveys S(NOLOCK) ON S.CaseNumber = C.CaseNumber
	AND S.CreatedDate >= '2020-01-01'
WHERE C.CreatedDate >= '2020-01-01'