




/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_ECC_MiCC_Group] as 
--MW 07282020 for ECC Migration testing
SELECT 
	    'ECC' As Source
	  ,[Created]
      ,[ReportRecordId]
      ,[ReportDate]
      ,[ACDCallsAccepted]
      ,[ACDCallsAnswered]
      ,[ChatContactsAccepted]
      ,[ChatContactsAnswered]
      ,[EmailContactsAccepted]
      ,[EmailContactsAnswered]
      ,[AvgWaitTimeBeforeAnswered]
      ,[AvgWaitTimeInQueueOfCallsRequestedCallback]
      ,[LongestWaitTimeBeforeAnswered]
      ,[LongestWaitTimeInQueueOfCallRequestedCallback]
      ,[AvgWaitTimeBeforeAnsweredOfChatContacts]
      ,[CmltvWaitTimeBeforeAnsweredOfChatContacts]
      ,[OutboundACDCallsAsAConsequenceOfCallback]
      ,[GroupID]
      ,[GroupName]
      ,[TSFForIncomingACDCalls]
      ,[LongestWaitTimeBeforeAnsweredChatContacts]
      ,[PCTACDCallsAbandonedOfAcceptedCalls]
      ,[AvgTalkTimeACDCalls]
      ,[AvgNumberLoggedinAgents]
      ,[MaximumNumberAgentsLoggedInSimultaneously]
      ,[ACDCallsAbandoned]
      ,[ACDCallsRequestedCallbackWhileWaitingInQueue]
      ,[ACDCallsOverflowedInAndAnswered]
      ,[NumberOfCallsAnsweredWithinTASA]
      ,[CumulativeTalkTimeOfIncomingACDCalls]
      ,[CumulativeWaitTimeBeforeAnsweredOfACDIncoming]
      ,[AvgWaitTimeBeforeAnsweredEmailContacts]
      ,[LongestQueueTimeBeforeAnsweredEmailContacts]
      ,[AvgInteractionTimeEmailContacts]
      ,[CmltvTalkTimeACDCalls]
      ,[GlobalAggCmltvInteractionTimeEmailContacts]
      ,[TSFEmailContacts]
      ,[CmltvIntTimeEmailContacts]
  FROM [dbo].[ECC_GROUPBYDATE] (nolock)
where ReportDate >= '2020-01-01'
UNION ALL
select 

	    Source
	  ,[Created]
      ,[ReportRecordId]
      ,[ReportDate]
      ,[ACDCallsAccepted]
      ,[ACDCallsAnswered]
      ,[ChatContactsAccepted]
      ,[ChatContactsAnswered]
      ,[EmailContactsAccepted]
      ,[EmailContactsAnswered]
      ,[AvgWaitTimeBeforeAnswered]
      ,[AvgWaitTimeInQueueOfCallsRequestedCallback]
      ,[LongestWaitTimeBeforeAnswered]
      ,[LongestWaitTimeInQueueOfCallRequestedCallback]
      ,[AvgWaitTimeBeforeAnsweredOfChatContacts]
      ,[CmltvWaitTimeBeforeAnsweredOfChatContacts]
      ,[OutboundACDCallsAsAConsequenceOfCallback]
      ,[GroupID]
      ,[GroupName]
      ,[TSFForIncomingACDCalls]
      ,[LongestWaitTimeBeforeAnsweredChatContacts]
      ,[PCTACDCallsAbandonedOfAcceptedCalls]
      ,[AvgTalkTimeACDCalls]
      ,[AvgNumberLoggedinAgents]
      ,[MaximumNumberAgentsLoggedInSimultaneously]
      ,[ACDCallsAbandoned]
      ,[ACDCallsRequestedCallbackWhileWaitingInQueue]
      ,[ACDCallsOverflowedInAndAnswered]
      ,[NumberOfCallsAnsweredWithinTASA]
      ,[CumulativeTalkTimeOfIncomingACDCalls]
      ,[CumulativeWaitTimeBeforeAnsweredOfACDIncoming]
      ,[AvgWaitTimeBeforeAnsweredEmailContacts]
      ,[LongestQueueTimeBeforeAnsweredEmailContacts]
      ,[AvgInteractionTimeEmailContacts]
      ,[CmltvTalkTimeACDCalls]
      ,[GlobalAggCmltvInteractionTimeEmailContacts]
      ,[TSFEmailContacts]
      ,[CmltvIntTimeEmailContacts]

from MiCC_Group (nolock)
-- MW 20201004  at cutover
where ReportDate > '2020-10-02'
-- Exclude Email Qs
and GroupName not like  '%Email Office 365%' 

/*
SELECT
		 'MiCC' As Source
		,null as 	       [Created]
		, 	      [ReportRecordId] collate database_default as ReportRecordId
		, 	      [ReportDate]
		, 	      [ACDCallsAccepted]
		,  	      [ACDCallsAnswered]
		,null as 	      [ChatContactsAccepted]
		,null as 	      [ChatContactsAnswered]
		,null as 	      [EmailContactsAccepted]
		,null as 	      [EmailContactsAnswered]
		,null as 	      [AvgWaitTimeBeforeAnswered]
		,null as 	      [AvgWaitTimeInQueueOfCallsRequestedCallback]
		,null as 	      [LongestWaitTimeBeforeAnswered]
		,null as 	      [LongestWaitTimeInQueueOfCallRequestedCallback]
		,null as 	      [AvgWaitTimeBeforeAnsweredOfChatContacts]
		,null as 	      [CmltvWaitTimeBeforeAnsweredOfChatContacts]
		,null as 	      [OutboundACDCallsAsAConsequenceOfCallback]
		,null as 	      [GroupID]
		, [GroupName]  collate database_default
		,null as 	      [TSFForIncomingACDCalls]
		,null as 	      [LongestWaitTimeBeforeAnsweredChatContacts]
		,null as 	      [PCTACDCallsAbandonedOfAcceptedCalls]
		,null as 	      [AvgTalkTimeACDCalls]
		,null as 	      [AvgNumberLoggedinAgents]
		,null as 	      [MaximumNumberAgentsLoggedInSimultaneously]
		,null as 	      [ACDCallsAbandoned]
		,null as 	      [ACDCallsRequestedCallbackWhileWaitingInQueue]
		,null as 	      [ACDCallsOverflowedInAndAnswered]
		,null as 	      [NumberOfCallsAnsweredWithinTASA]
		,  	      [CumulativeTalkTimeOfIncomingACDCalls]
		, 	      [CumulativeWaitTimeBeforeAnsweredOfACDIncoming]
		,null as 	      [AvgWaitTimeBeforeAnsweredEmailContacts]
		,null as 	      [LongestQueueTimeBeforeAnsweredEmailContacts]
		,null as 	      [AvgInteractionTimeEmailContacts]
		,null as 	      [CmltvTalkTimeACDCalls]
		,null as 	      [GlobalAggCmltvInteractionTimeEmailContacts]
		,null as 	      [TSFEmailContacts]
		,null as 	      [CmltvIntTimeEmailContacts]
FROM
(
SELECT 
	   QueueFullNameName                                AS GroupName,
       CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) AS ReportDate,
       CONVERT(VARCHAR(10), DateKey) + '_'
       + QueueReporting                                 AS ReportRecordId,
	   Sum( Offered )                                  AS ACDCallsAccepted,
       Sum( Answered )                                  AS ACDCallsAnswered,
       Dateadd( s, Sum( CASE
                          WHEN DeviceACDDuration < 0 THEN 0
                          ELSE DeviceACDDuration
                        END ), '19700101' )             AS CumulativeTalkTimeOfIncomingACDCalls,
       Dateadd( s, Sum( TimeToAnswer ), '19700101' )    AS CumulativeWaitTimeBeforeAnsweredOfACDIncoming
FROM   [CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].QUEUEFACTS_QUEUEPERFORMANCEBYPERIOD
GROUP  BY QueueFullNameName,CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ),CONVERT(VARCHAR(10), DateKey) + '_'
          + QueueReporting 
) a
*/


