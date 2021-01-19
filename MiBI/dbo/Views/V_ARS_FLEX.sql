






CREATE view [dbo].[V_ARS_FLEX] as 
-- MW 01302020 view to reproduce At Risk for FLex
SELECT

--At Risk Situation Fields - VwArs
 
 [ARSCount]  [ARS Count]
,[ARSID]  [At Risk Situation ID]
,a.[AtRiskNow]
,[CreatedBy]
,[CreatedDate]
,[DateLost]
,[DateSaved]
,[EffectiveMRRChangeDate]
,[M5DBAccountId]
-- MW 02052020 PER Chad
-- Should always be negative
,  CASE WHEN CAST([PendingMRRChange] as float) >= 0 then -1*CAST([PendingMRRChange] as float)
	ELSE CAST([PendingMRRChange] as float) END as PendingMRRChange
,[RootCausePrimary]
,[RootCauseSecondary]
,[RootCauseTertiary]
,a.[Status] [ARS Status]
,[TriggerField]  [Trigger]
,[WeeklyUpdate]  [Executive Update]

 
,b.Theater as [Theatre]
,[Region]
--,[SubRegion]
,b.STTerritory as [TerritoryName]
,b.OwnerName as [AM]
,b.AccountTeam as [Ac Team]
,b.Platform
,b.NAME as AccountName
--,b.CustomerType
,Description

,b.CSM

FROM  
	ARS a inner join
	CUSTOMERS b on a.AccountID = b.SfdcId
where  
-- MW 02052020 CustomerType seems to be top tier, then platform has FBO types.
b.CustomerType = 'MiCloud Flex' 


--( b.Platform in ( 'MiCloud Flex' , 'MiCloud Business' ,'MiCloud Office'  )  
--OR
--b.CustomerType IN  ( 'MiCloud Flex' , 'MiCloud Business' ,'MiCloud Office'  )
--)
 
