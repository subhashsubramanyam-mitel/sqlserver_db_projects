/****** Script for SelectTopNRows command from SSMS  ******/


Create VIew V_TABLEAU_DEBOOK_OPP as 
-- MW 12022020 For inclusion in pipeline
SELECT  
       a.[OpportunityID]
 
    ,'Yes' as [Debooked Opportunity]
 
  FROM  [OPPORTUNITY] a (nolock) inner join
		[OPPORTUNITY] b (nolock) on  a.OpportunityID = b.DebookedOppId  
where a.Created >= '2020-01-01'
