






 CREATE view [dbo].[V_MiCC_EmailStatMap] as
 -- MW 10052020  Translate Email queues to the rollup queue

 -- MW 12292020 No Longer used

 
 select
     convert(nvarchar(100), rtrim( CONVERT(VARCHAR(10), DateKey) + '_'
       + b.QueueReporting   + '_' +   b.GroupName    ) )                        AS ReportRecordId,
	   Sum( Offered )                                  AS EmailContactsAccepted,
       Sum( Answered )                                  AS EmailContactsAnswered ,
       Dateadd( s, Sum( case when TimeToAnswer <0 then 0 else TimeToAnswer end  ), '19700101' )    AS CmltvIntTimeEmailContacts,
	   Dateadd( s, max( case when TimeToAnswer <0 then 0 else TimeToAnswer end  ), '19700101' )    AS [LongestQueueTimeBeforeAnsweredEmailContacts],
	   Dateadd( s, avg( case when TimeToAnswer <0 then 0 else TimeToAnswer end  ), '19700101' )     as AvgWaitTimeBeforeAnsweredEmailContacts
FROM   [CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].QUEUEFACTS_QUEUEPERFORMANCEBYPERIOD a inner join
		MiCC_EmailGroupMap b on a.QueueFullNameName = b.EmailGroup collate database_default -- Mapped to Q
--Before today
where CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) <  getdate() 
GROUP by   CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ),CONVERT(VARCHAR(10), DateKey) + '_'
          + b.QueueReporting   + '_' +   b.GroupName   
