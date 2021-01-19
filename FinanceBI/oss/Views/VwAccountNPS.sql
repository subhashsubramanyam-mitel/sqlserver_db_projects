
CREATE VIEW [oss].[VwAccountNPS]
AS
SELECT 
	AccountID, 
	MAX(CASE WHEN CCRankAsc = 1 THEN Referencability ELSE -1 END) as FirstScore,
	MAX(CASE WHEN CCRankDesc = 1 THEN Referencability ELSE -1 END) as LastScore,
	MAX(CASE WHEN CCRankAsc = 1 THEN DateScored ELSE Null END) as DateFirstScored,
	MAX(CASE WHEN CCRankDesc = 1 THEN DateScored ELSE Null END) as DateLastScored
FROM (
/* 2019-05-20 After discussion with Mark, since the data is way old, decided to ignore it 
	select AccountId, Referencability, DateScored,
	ROW_NUMBER() over (PARTITION BY AccountId ORDER BY dATEsCORED ASC) 
				as CCRankAsc,
	ROW_NUMBER() over (PARTITION BY AccountId ORDER BY dATEsCORED DESC) 
				as CCRankDesc	
	From oss.Nps	
	*/
	select 0 AccountId, 0 Referencability, '2000-01-01'  DateScored, 1 CCRankAsc, 1 CCRankDesc
				
	) foo	
GROUP BY AccountId

