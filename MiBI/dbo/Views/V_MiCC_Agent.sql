CREATE VIEW [dbo].[V_MiCC_Agent]
AS
-- MW 08182020 For MiCC agent reports 
-- MiCC
SELECT 'MiCC' AS Source
	,RecordId collate database_default AS [ReportRecordId]
	,NULL AS [Created]
	,ReportDate AS [Date]
	,NULL AS [PCTACDabandonedcallsofACDpresented]
	,NULL AS [PCTCmltvidletimeformultiplegroups]
	,NULL AS [PCTReleasetime]
	,NULL AS [PCTReleasetimeformultiplegroups]
	,ACDabandonedcalls AS [ACDabandonedcalls]
	,[ACDansweredcalls]
	,NULL AS [ACDpresentednotansweredcalls]
	,NULL AS [AgentNameDel]
	,NULL AS [AgentNumberDel]
	,NULL AS [AvgACDemailinteractiontime]
	,NULL AS [AvgACDholdtime]
	,NULL AS [AvgACDtalktime]
	,NULL AS [AvgACDWrapuptime]
	,NULL AS [AvgtalktimeofNACDincoming]
	,NULL AS [AvgtalktimeofNACDoutgoing]
	,NULL AS [Chatcontactsanswered]
	,ACDDuration AS [Cmltvlogintime]
	,NULL AS [Cmltvreleasetimeformultiplegroups]
	,ACDDuration AS [CmltvtalktimeofNACDoutgoing]
	,NULL AS [Emailcontactsanswered]
	,NULL AS [NACDincomingcalls]
	,NULL AS [Logintimeformultiplegroups]
	,[LongestACDtalktime]
	,EmployeeID AS [AgentID]
	,EmployeeID AS [AgentNumber]
	,EmployeeFullName collate database_default AS [AgentName]
	,[ACDPresentedCalls]
	,NULL AS [ChatContactsPresented]
	,NULL AS [EmailContactsPresented]
	,NULL AS [AvgACDChatInteractionTime]
	,NULL AS [LongestACDChatInteractionTime]
	,NULL AS [LongestACDEmailInteractionTime]
	,NULL AS [ChatContactsPresentedNotAnswered]
	,NULL AS [CmltvACDEmailInteractionTime]
	,OutboundACDPresented AS [OutboundACDAnswered]
	,NULL AS [CmltvIdleTimeForMultipleGroups]
	,NULL AS [NACDOutgoingCalls]
	,[OutboundACDPresented]
	,b.SfdcId AS AgentSfdcId
FROM (
	SELECT EmployeeID
		,EmployeeFullName
		,CONVERT(DATETIME, CONVERT(VARCHAR(10), DateKey)) AS ReportDate
		,CONVERT(VARCHAR(10), DateKey) + '_' + CONVERT(VARCHAR(10), Isnull(EmployeeID, 0)) + '_' + Isnull(EmployeeFullName, '') AS RecordId
		,Sum(ACDCount) AS ACDansweredcalls
		,Sum(ACDCount + RequeueCount) AS ACDPresentedCalls
		,sum(ExternalACDCount) AS OutboundACDPresented
		,Dateadd(s, Sum(Cast(CASE -- cleanse data
						WHEN ACDDuration < 0
							THEN 0
						ELSE ACDDuration
						END AS FLOAT)), '19700101') AS ACDDuration
		,Dateadd(s, Sum(Cast(ACDTimeToAnswer AS FLOAT)), '19700101') AS ACDTimeToAnswer
		,Sum(Cast(AbandonCount AS FLOAT)) AS ACDabandonedcalls
		,Dateadd(s, max(Cast(ACDDuration AS FLOAT)), '19700101') AS LongestACDtalktime
	FROM [$(CLUMICC)].[$(CCMStatisticalData)].[dbo].[DEVICECALLFACT_EXTENSIONPERFORMANCEBYPERIOD]
	WHERE EmployeeID <> 0
		AND CONVERT(DATETIME, CONVERT(VARCHAR(10), DateKey)) >= '2020-10-03'
		AND CONVERT(DATETIME, CONVERT(VARCHAR(10), DateKey)) < getdate()
	--and ACDDuration >0  -- Avoid error
	GROUP BY EmployeeID
		,EmployeeFullName
		,CONVERT(DATETIME, CONVERT(VARCHAR(10), DateKey))
		,CONVERT(VARCHAR(10), DateKey) + '_' + CONVERT(VARCHAR(10), Isnull(EmployeeID, 0)) + '_' + Isnull(EmployeeFullName, '')
	) a
LEFT OUTER JOIN dbo.V_MiCC_AGENT_LOOKUP b ON a.EmployeeID = b.Extension collate database_default
	AND b.rn = 1