
/****** Script for SelectTopNRows command from SSMS  ******/


CREATE view [dbo].[V_MiCC_AGENT_LOOKUP] as 
-- MW 09282020 for agent mapping to SFDC 
with sfdc as (
SELECT 
		ID as SfdcId
      ,[Name]
      ,[Extension]
	  ,CreatedDate
  FROM [dbo].[Users] (nolock)
  where Extension is not null
  and Active = 'true'
  )
,  Agent as (
  select 
	 Pkey
	,Reporting as Extension
	,[FirstName] +' '+[LastName] as Name
  from 
   [CLUMICC.MITEL.COM\MICC].[CCMData].[dbo].[tblConfig_Agent]
   )

select 
			 a.SfdcId
			,a.Extension
			,a.Name as SFDCName
			,b.Name as AgentName
			,row_number() over (partition by a.Extension order by a.CreatedDate desc) rn
from			
				sfdc a
	 inner join Agent b on a.Extension = b.Extension collate database_default
	
