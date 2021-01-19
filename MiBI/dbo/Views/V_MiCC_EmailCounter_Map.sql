
 Create view [V_MiCC_EmailCounter_Map]  as
-- MW 12292020 new for email stats
 select
     convert(nvarchar(100), rtrim( CONVERT(VARCHAR(10), DateKey) + '_'
       + b.QueueReporting   + '_' +   b.GroupName    ) )                        AS ReportRecordId,
	   Sum( ACDEmailsOffered )                                  AS EmailContactsAccepted,
       Sum( ACDEmailsHandled )                                  AS EmailContactsAnswered  
FROM   [V_MiCC_EmailCounter] a inner join
		MiCC_EmailGroupMap b on a.QueueName = b.EmailGroup collate database_default -- Mapped to Q
--Before today
where CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ) <  getdate() 
GROUP by   CONVERT( DATEtime, CONVERT( VARCHAR(10), DateKey ) ),CONVERT(VARCHAR(10), DateKey) + '_'
          + b.QueueReporting   + '_' +   b.GroupName  