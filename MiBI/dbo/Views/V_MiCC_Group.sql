















/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_MiCC_Group] as 
--MW 08182020 for MiCC Import
 
SELECT
		 'MiCC' As Source
		,getdate() as 	       [Created]
		, 	      [ReportRecordId] collate database_default as ReportRecordId
		, 	      [ReportDate]
		, 	      [ACDCallsAccepted]
		,  	      [ACDCallsAnswered]
		,null as 	      [ChatContactsAccepted]
		,null as 	      [ChatContactsAnswered]
		,null as 	      [EmailContactsAccepted]
		,null as 	      [EmailContactsAnswered]
		, 	      [AvgWaitTimeBeforeAnswered]
		,null as 	      [AvgWaitTimeInQueueOfCallsRequestedCallback]
		,		 	      [LongestWaitTimeBeforeAnswered]
		,null as 	      [LongestWaitTimeInQueueOfCallRequestedCallback]
		,null as 	      [AvgWaitTimeBeforeAnsweredOfChatContacts]
		,null as 	      [CmltvWaitTimeBeforeAnsweredOfChatContacts]
		,null as 	      [OutboundACDCallsAsAConsequenceOfCallback]
		,null as 	      [GroupID]
		, [GroupName]  collate database_default as GroupName
		,null as 	      [TSFForIncomingACDCalls]
		,null as 	      [LongestWaitTimeBeforeAnsweredChatContacts]
		,null as 	      [PCTACDCallsAbandonedOfAcceptedCalls]
		,null as 	      [AvgTalkTimeACDCalls]
		,null as 	      [AvgNumberLoggedinAgents]
		,null as 	      [MaximumNumberAgentsLoggedInSimultaneously]
		,ACDCallsAbandoned as 	      [ACDCallsAbandoned]
		,null as 	      [ACDCallsRequestedCallbackWhileWaitingInQueue]
		,null as 	      [ACDCallsOverflowedInAndAnswered]
		,null as 	      [NumberOfCallsAnsweredWithinTASA]
		,  	      [CumulativeTalkTimeOfIncomingACDCalls]
		, 	      [CumulativeWaitTimeBeforeAnsweredOfACDIncoming]
		,null as 	      [AvgWaitTimeBeforeAnsweredEmailContacts]
		,null as 	      [LongestQueueTimeBeforeAnsweredEmailContacts]
		,null as 	      [AvgInteractionTimeEmailContacts]
		,CumulativeTalkTimeOfIncomingACDCalls as 	      [CmltvTalkTimeACDCalls]
		,null as 	      [GlobalAggCmltvInteractionTimeEmailContacts]
		,null as 	      [TSFEmailContacts]
		,null as 	      [CmltvIntTimeEmailContacts]
FROM
(
SELECT 
	   QueueFullNameName                                AS GroupName,
       CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) AS ReportDate,
       CONVERT(VARCHAR(10), DateKey) + '_'
       + QueueReporting   + '_' +   QueueFullNameName                            AS ReportRecordId,
	   Sum( Offered + Requeue )                                  AS ACDCallsAccepted,
       Sum( Answered )                                  AS ACDCallsAnswered,
	   SUM(LongAbandon)		AS ACDCallsAbandoned,
       Dateadd( s, Sum( CASE
                          WHEN DeviceACDDuration < 0 THEN 0
                          ELSE DeviceACDDuration
                        END ), '19700101' )       AS CumulativeTalkTimeOfIncomingACDCalls,
       Dateadd( s, Sum( CASE WHEN TimeToAnswer < 0 then 0 else TimeToAnswer end ), '19700101' )    AS CumulativeWaitTimeBeforeAnsweredOfACDIncoming,
	   Dateadd( s, max(  CASE WHEN TimeToAnswer < 0 then 0 else TimeToAnswer end  ), '19700101' )    AS LongestWaitTimeBeforeAnswered,
	   Dateadd( s, avg(  CASE WHEN TimeToAnswer < 0 then 0 else TimeToAnswer end  ), '19700101' )    AS AvgWaitTimeBeforeAnswered
FROM   --[CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].Monet_QueuePerformanceByPeriod   --QUEUEFACTS_QUEUEPERFORMANCEBYPERIOD
		MiCC_GROUP_RAW
--Before today
where DateKey  < convert (Char(10), getdate(),112)  and DateKey  >  convert (Char(10), getdate()-10,112) 
		--CONVERT( DATEtime, CONVERT( VARCHAR(10),  ) ) <  getdate() and
  --      CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) >  getdate() -3

    and DateKey <> '20201009'
--MW 10112020  int overflow bug....
--and QueueKey not in
--(
--'0F2F6980-BDE5-476A-AD1E-28E94A3119D3',
--'0F2F6980-BDE5-476A-AD1E-28E94A3119D3',
--'0F2F6980-BDE5-476A-AD1E-28E94A3119D3',
--'37EBD58F-F9DE-4303-8FFD-E5EF3978E57E',
--'EC4BCC94-547B-4B52-A2BA-63C1E897C8AE',
--'63E189B3-0A22-46CA-A270-01FD0E66BB55'

--)
 
GROUP  BY QueueFullNameName,CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ),CONVERT(VARCHAR(10), DateKey) + '_'
          + QueueReporting   + '_' +   QueueFullNameName  
 
) a
