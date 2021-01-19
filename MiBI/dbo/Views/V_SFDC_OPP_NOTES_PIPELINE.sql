CREATE View V_SFDC_OPP_NOTES_PIPELINE as 
-- MW 05042020 For Evo's request for notes modified after Opp Close, to be brought into pipeline

select 
	 a.Id  
	,a.Title
	,a.ModifiedDate
	,a.ModifiedBy
	,a.OppId
FROM
(
SELECT 
	 a.Id  
	,a.Title
	,a.ModifiedDate
	,a.ModifiedBy
	,a.ParentId as OppId
	,row_Number() over (partition by a.ParentId order by a.ModifiedDate desc ) rn
  FROM 
[SFDC_NOTES]  a (nolock) inner join
OPPORTUNITY b (nolock) on a.ParentId = b.OpportunityID
where a.ModifiedDate > b.CloseDate
) a 
where rn =1