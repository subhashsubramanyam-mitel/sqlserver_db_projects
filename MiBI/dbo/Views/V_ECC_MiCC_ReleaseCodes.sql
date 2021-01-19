

/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_ECC_MiCC_ReleaseCodes] as
-- MW 07302020 combined release codes
SELECT 
		'ECC' as Source
      ,[ReportDate]
      ,[ReportRecordId]
      ,[ReleaseCode]
      ,[GroupIndependentRT]
      ,[TimesCodeWasUsed]
      ,[ShortestGroupIndependantRT]
      ,[AgentId]
      ,[AgentName]
  FROM [dbo].[ECC_RELEASECODE]
where ReportDate >= '2020-01-01'
UNION ALL
SELECT 
 		'MiCC' as Source
       ,Convert(varchar(10), a.[MidnightStartDate],121) as ReportDate
	   ,Convert(varchar(10), a.[MidnightStartDate],121) + '_'+convert(varchar(150),AgentID) + '_'+ a.MakeBusyCodeName collate database_Default  as ReportRecordId
	   ,a.MakeBusyCodeName collate database_Default as ReleaseCode 
	   
	   , DATEADD(s,  SUM([AgentByMakeBusyDuration])  , '19700101') as GroupIndependentRT  
      ,SUM([AgentByMakeBusyCount]) as TimesCodeWasUsed
	  , DATEADD(s,  SUM([AgentByMakeBusyDuration])  , '19700101') as ShortestGroupIndependantRT

		,null as AgentId
		,AgentFirstName + ' ' + AgentLastName   collate database_Default  as  EmployeeFullName  
  FROM 
	  [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].[AgentByMakeBusyCodeStats]  a
	 -- [CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].[DimAgent] b on a.AgentReporting =b.DeviceReporting
where a.MidnightStartDate  > '2020-10-01'  
and AgentMediaServerName = 'user02.amer'
--and a.MidnightStartDate  < '2020-10-22'  and AgentID = '39846D93-E850-436C-A3C2-92D915178B33'
--and b.DeviceMediaServerType = 'Voice' and AgentMediaServerName = 'user02.amer'
group by         
		AgentID
	   ,AgentFirstName + ' ' + AgentLastName collate database_Default  
	   ,Convert(varchar(10), a.[MidnightStartDate],121) 
	   ,Convert(varchar(10), a.[MidnightStartDate],121) + '_'+convert(varchar(150),AgentID) + '_'+ a.MakeBusyCodeName 
	   ,a.MakeBusyCodeName


/* the join caused dupes

SELECT 
 		'MiCC' as Source
       ,Convert(varchar(10), a.[MidnightStartDate],121) as ReportDate
	   ,Convert(varchar(10), a.[MidnightStartDate],121) + '_'+convert(varchar(10),b.EmployeeID) + '_'+ a.MakeBusyCodeName collate database_Default  as ReportRecordId
	   ,a.MakeBusyCodeName collate database_Default as ReleaseCode 
	   
	   , DATEADD(s,  SUM([AgentByMakeBusyDuration])  , '19700101') as GroupIndependentRT  
      ,SUM([AgentByMakeBusyCount]) as TimesCodeWasUsed
	  , DATEADD(s,  SUM([AgentByMakeBusyDuration])  , '19700101') as ShortestGroupIndependantRT

		,b.EmployeeID as AgentId
		,b.EmployeeFullName collate database_Default as AgentName
  FROM 
	  [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].[AgentByMakeBusyCodeStats] a inner join
	  [CLUMICC.MITEL.COM\MICC].[CCMStatisticalData].[dbo].[DimAgent] b on a.AgentReporting =b.DeviceReporting
where a.MidnightStartDate >= '2020-07-20'
group by         
		Convert(varchar(10), a.[MidnightStartDate],121) 
	   ,Convert(varchar(10), a.[MidnightStartDate],121) + '_'+convert(varchar(10),b.EmployeeID) + '_'+ a.MakeBusyCodeName 
	   ,a.MakeBusyCodeName
	   ,b.EmployeeFullName
	   ,b.EmployeeID

*/
