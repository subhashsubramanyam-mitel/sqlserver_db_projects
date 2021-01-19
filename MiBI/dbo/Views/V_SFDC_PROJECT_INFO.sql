
/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[V_SFDC_PROJECT_INFO] as
-- MW 09092019 custom View sourced by Boss Pipeline.
-- MW 021220 since OA went away, lets get rid of dups and put to table
select * from SFDC_BOSSPIPELINE_OPENAIR_LOOKUP

/*
SELECT  
       a.[ProjectId]
      ,a.[OppId]
      ,a.[ProjectOwnerName]
      ,a.[ProjectStartDate]
      ,a.[ProjectTargetCompleteDate]
      ,a.[ProjectStatus]
      ,a.[ProjectPctComplete]
      ,a.[OAProjectId]
      ,a.[ProjectOwnerId]
      ,a.[DelayReason]
      ,a.[DelayDescription]
	  ,a.OpportunityNumber  into SFDC_BOSSPIPELINE_OPENAIR_LOOKUP
from
(
SELECT  
       a.[ProjectId]
      ,a.[OppId]
      ,a.[ProjectOwnerName]
      ,a.[ProjectStartDate]
      ,a.[ProjectTargetCompleteDate]
      ,a.[ProjectStatus]
      ,a.[ProjectPctComplete]
      ,a.[OAProjectId]
      ,a.[ProjectOwnerId]
      ,a.[DelayReason]
      ,a.[DelayDescription]
	  ,b.OpportunityNumber
	  ,Row_number() over (partition by  b.OpportunityNumber order by a.Created desc) rn
  FROM  [SFDC_PROJECT] a inner join
        OPPORTUNITY b on a.OppId = b.OpportunityID
) a where a.rn=1
*/
 
