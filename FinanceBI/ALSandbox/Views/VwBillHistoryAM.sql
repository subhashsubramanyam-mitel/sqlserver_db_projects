CREATE VIEW ALSandbox.VwBillHistoryAM AS

WITH CTE AS
(
select *
	, ROW_NUMBER () OVER (PARTITION BY Id ORDER BY DateModified ASC) AS ChangeNum
from (
SELECT  H.[Id]
      ,[DateModified]
      ,[ModifiedBy]
      ,[AccountManagerId]
      ,[AccountTeamId]
      ,[AccountAdvocateId]
      ,concat(P.FirstName, ' ', P.LastName) AM
       -- ,AT.Name Team
 
  FROM [M5DB2].[m5db].[dbo].[history_Account] H
   left join people.Person P on P.Id = H.AccountManagerId
  -- left join M5DB2.m5db.dbo.AccountTeam AT on AT.Id = H.AccountTeamId
 
  WHERE H.DateModified > Dateadd(month,-25, GETDATE())  -- 25 months hisotry
  union all
  SELECT  H.[Id]
      ,[DateModified]
      ,[ModifiedBy]
      ,[AccountManagerId]
      ,[AccountTeamId]
      ,[AccountAdvocateId]
         ,concat(P.FirstName, ' ', P.LastName) AM
       --  ,AT.Name Team
  FROM [M5DB2].[m5db].[dbo].[Account] H
  left join people.VwPerson P on P.Id = H.AccountManagerId
  -- left join M5DB2.m5db.dbo.AccountTeam AT on AT.Id = H.AccountTeamId
  WHERE H.DateModified > Dateadd(month,-25, GETDATE())  -- 25 months hisotry
  ) foo
--WHERE Id IN (20,221,238)
),

ChangeLog AS 
(
SELECT AccountId
	,FromDate
	,ToDate
	,GapAM
	,GapTeam
	,NewAM
	,NewTeam
	,CASE WHEN ChangeNum = 1 THEN 1 ELSE 0 END AS FirstRecord
	,CASE WHEN ChangeNumInv = 1 THEN 1 ELSE 0 END AS LastRecord
FROM
	(
	SELECT x.*
		, ROW_NUMBER () OVER (PARTITION BY AccountId ORDER BY FromDate ASC) AS ChangeNum
		, ROW_NUMBER () OVER (PARTITION BY AccountId ORDER BY ToDate DESC) AS ChangeNumInv
	FROM 
		(
		SELECT  New.Id AccountId
				,Prev.DateModified AS FromDate
				,New.DateModified AS ToDate
				,Prev.AM  AS GapAM
				,Prev.AccountTeamId AS GapTeam
				,New.AM As NewAM
				,New.AccountTeamId as NewTeam
				
		
                
		FROM CTE as New
		INNER JOIN CTE AS Prev
			ON Prev.ChangeNum = New.ChangeNum - 1
				AND Prev.Id = New.Id
				--AND (coalesce(New.AccountManagerId, 0) <> coalesce(Prev.AccountManagerId, 0)
				--	OR
				--	coalesce(New.AccountTeamId, 0) <> coalesce(Prev.AccountTeamId, 0))
		) x
	) y
),														  
History AS
(
SELECT AccountId
	,FromDate
	,ToDate
	,GapAM AS AM
	,GapTeam AS Team
FROM ChangeLog
union all
SELECT AccountId
	,NULL AS FromDate
	,FromDate AS ToDate
	,GapAM AS AM
	,GapTeam AS Team
FROM ChangeLog
WHERE FirstRecord = 1
union all
SELECT AccountId
	,ToDate AS FromDate
	,NULL AS ToDate
	,NewAM AS AM
	,NewTeam AS Team
FROM ChangeLog
WHERE LastRecord = 1


),

Bill AS
(
SELECT [DateGenerated] As InvoiceDate
		,[AccountId]
		,[Ac Name]
		,AM AS CurrentAM
		,[Ac Team] AS CurrentTeam
		,SUM([MRR]) AS MRR

FROM [invoice].[VwLineItem] L
INNER JOIN ALSandbox.VwAccountWRegion A
	ON A.[Ac Id] = L.AccountId
WHERE DateGenerated >= dateadd(month,-25,GETDATE())     
	AND IsBillable = 1              
GROUP BY DateGenerated, AccountId, [Ac Name], AM, [Ac Team]
)


	SELECT Bill.*
		,coalesce(History.AM, CurrentAM) AS AM
		,History.Team AS HistoryTeam

	FROM Bill
	LEFT JOIN History
		ON History.AccountId = Bill.AccountId
			AND Bill.InvoiceDate <= coalesce(History.ToDate,GETDATE())
			AND Bill.InvoiceDate >= coalesce(History.FromDate,dateadd(month,-25,GETDATE()))

--ORDER BY AccountId, InvoiceDate