









-- SELECT * FROM [dbo].[V_TABLEAU_TASKFEED_BOARD]
CREATE VIEW [dbo].[V_TABLEAU_TASKFEED_BOARD]
AS
-- MW 10212019 For Tableau Reporting
SELECT Created AS CreateDate
	,Id AS BoardSfdcId
	,OwnerId AS OwnerId
	,taskfeed1__Pc_Complete__c AS PctComplete
	,taskfeed1__Account__c AS AccountId
	,taskfeed1__Decays_Warning_Amber__c AS DecaysWarningAmber
	,taskfeed1__Decays_Warning_Red__c AS DecaysWarningRed
	,Delay_Reason__c AS DelayReason
	,taskfeed1__Duration__c AS DurationDays
	,taskfeed1__End_Date__c AS EndDate
	,taskfeed1__End_Date_Baseline__c AS EndDateBaseline
	,taskfeed1__End_Variance__c AS EndVariance
	,taskfeed1__Is_Complete__c AS IsComplete
	,Location__c AS Location
	,taskfeed1__Number_of_Completed_Tasks__c AS NumberofCompletedTasks
	,taskfeed1__Number_of_Lists__c AS NumberofLists
	,taskfeed1__Number_of_Tasks__c AS NumberofTasks
	,taskfeed1__Opportunity__c AS OpportunityId
	,Project_Number__c AS ProjectNumber
	,taskfeed1__Set_Baseline__c AS SetBaseline
	,taskfeed1__Stage__c AS Stage
	,taskfeed1__Start_Date__c AS StartDate
	,taskfeed1__Start_Date_Baseline__c AS StartDateBaseline
	,taskfeed1__Start_Variance__c AS StartVariance
	,taskfeed1__Status_Overview__c AS StatusOverview
	,taskfeed1__Task_Limit_Count__c AS TaskLimitCount
	,taskfeed1__Type__c AS Type
	,boss_location_id__c AS BossLocationId
	,M5DB_Account_ID__c AS BossAccountId
	,Name AS BoardName
	,Delay_Reason_Details__c AS DelayReasonDetails
	,taskfeed1__Color__c AS [TF Color Number]
	,LastModifiedDate
	,[dbo].[udf_StripHTML](substring(Notes, 0, 255)) AS TF_Project_Board_Notes
	,TF_External_Sharing
	,PRAScore
FROM SFDC_TASKFEED_BOARD
WHERE isDeleted = 0
 

