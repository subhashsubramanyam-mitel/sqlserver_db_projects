


CREATE View [dbo].[V_ECC_MiCC_Agent] as
-- MW 07302020 For combined agent reports 
SELECT 
		'ECC' as Source
	  ,[ReportRecordId]
      ,[Created]
      ,[Date]
      ,[PCTACDabandonedcallsofACDpresented]
      ,[PCTCmltvidletimeformultiplegroups]
      ,[PCTReleasetime]
      ,[PCTReleasetimeformultiplegroups]
      ,[ACDabandonedcalls]
      ,[ACDansweredcalls]
      ,[ACDpresentednotansweredcalls]
      ,[AgentNameDel]
      ,[AgentNumberDel]
      ,[AvgACDemailinteractiontime]
      ,[AvgACDholdtime]
      ,[AvgACDtalktime]
      ,[AvgACDWrapuptime]
      ,[AvgtalktimeofNACDincoming]
      ,[AvgtalktimeofNACDoutgoing]
      ,[Chatcontactsanswered]
      ,[Cmltvlogintime]
      ,[Cmltvreleasetimeformultiplegroups]
      ,[CmltvtalktimeofNACDoutgoing]
      ,[Emailcontactsanswered]
      ,[NACDincomingcalls]
      ,[Logintimeformultiplegroups]
      ,[LongestACDtalktime]
      ,[AgentID]
      ,[AgentNumber]
      ,[AgentName]
      ,[ACDPresentedCalls]
      ,[ChatContactsPresented]
      ,[EmailContactsPresented]
      ,[AvgACDChatInteractionTime]
      ,[LongestACDChatInteractionTime]
      ,[LongestACDEmailInteractionTime]
      ,[ChatContactsPresentedNotAnswered]
      ,[CmltvACDEmailInteractionTime]
      ,[OutboundACDAnswered]
      ,[CmltvIdleTimeForMultipleGroups]
      ,[NACDOutgoingCalls]
      ,[OutboundACDPresented]
	  ,null as ECCAgentId
  FROM [dbo].[ECC_AGENTBYDATE] (nolock)
where  Date >= '2020-01-01'
UNION ALL
-- MiCC
select * from MiCC_Agent
/*
SELECT
	'MiCC' as Source
	,RecordId  collate database_default as	  [ReportRecordId]
,null as	      [Created]
,ReportDate as	      [Date]
,null as	      [PCTACDabandonedcallsofACDpresented]
,null as	      [PCTCmltvidletimeformultiplegroups]
,null as	      [PCTReleasetime]
,null as	      [PCTReleasetimeformultiplegroups]
,ACDabandonedcalls as 	      [ACDabandonedcalls]
,	      [ACDansweredcalls]
,null as	      [ACDpresentednotansweredcalls]
,null as	      [AgentNameDel]
,null as	      [AgentNumberDel]
,null as	      [AvgACDemailinteractiontime]
,null as	      [AvgACDholdtime]
,null as	      [AvgACDtalktime]
,null as	      [AvgACDWrapuptime]
,null as	      [AvgtalktimeofNACDincoming]
,null as	      [AvgtalktimeofNACDoutgoing]
,null as	      [Chatcontactsanswered]
,null as	      [Cmltvlogintime]
,null as	      [Cmltvreleasetimeformultiplegroups]
,ACDDuration as 	      [CmltvtalktimeofNACDoutgoing]
,null as	      [Emailcontactsanswered]
,null as	      [NACDincomingcalls]
,null as	      [Logintimeformultiplegroups]
,null as	      [LongestACDtalktime]
,EmployeeID as	      [AgentID]
,EmployeeID as	      [AgentNumber]
,EmployeeFullName  collate database_default as 	      [AgentName]
,	      [ACDPresentedCalls]
,null as	      [ChatContactsPresented]
,null as	      [EmailContactsPresented]
,null as	      [AvgACDChatInteractionTime]
,null as	      [LongestACDChatInteractionTime]
,null as	      [LongestACDEmailInteractionTime]
,null as	      [ChatContactsPresentedNotAnswered]
,null as	      [CmltvACDEmailInteractionTime]
,null as	      [OutboundACDAnswered]
,null as	      [CmltvIdleTimeForMultipleGroups]
,null as	      [NACDOutgoingCalls]
,null as	      [OutboundACDPresented]

FROM
(
SELECT EmployeeID,
       EmployeeFullName,
       CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) )                  AS ReportDate,
       CONVERT(VARCHAR(10), DateKey) + '_'
       + CONVERT(VARCHAR(10), Isnull(EmployeeID, 0))
       + '_' + Isnull(EmployeeFullName, '')                              AS RecordId,
       Sum( ACDCount )                                                   AS ACDansweredcalls,
       Sum( ACDCount )                                                   AS ACDPresentedCalls,
       Dateadd( s, Sum( Cast( CASE -- cleanse data
                                WHEN ACDDuration < 0 THEN 0
                                ELSE ACDDuration
                              END AS FLOAT ) ), '19700101' )             AS ACDDuration,
       Dateadd( s, Sum( Cast( ACDTimeToAnswer AS FLOAT ) ), '19700101' ) AS ACDTimeToAnswer,
       Sum( Cast( AbandonCount AS FLOAT ) )                              AS ACDabandonedcalls
FROM   [CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].[DEVICECALLFACT_EXTENSIONPERFORMANCEBYPERIOD]  
WHERE  EmployeeID <> 0 AND
       CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) >= '2020-01-01'
--and ACDDuration >0  -- Avoid error
GROUP  BY EmployeeID,EmployeeFullName,CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ),CONVERT(VARCHAR(10), DateKey) + '_'
          + CONVERT(VARCHAR(10), Isnull(EmployeeID, 0))
          + '_' + Isnull(EmployeeFullName, '') 
) a
*/


