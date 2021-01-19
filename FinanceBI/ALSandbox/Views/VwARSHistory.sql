

--DROP VIEW ALSandbox.VwARSHistory 

CREATE VIEW [ALSandbox].[VwARSHistory] AS

WITH CTE AS (		
			SELECT D.[IndividualDate]
				--,ARS.[AccountID]
				,ARS.AccountId
				,ARS.ID
				,ARS.[DateLost]
				,ARS.[CreatedDate]
				,ARS.[Status] AS 'CurrentStatus'
				,ARS.ParentStatus AS 'CurrentParentStatus'
				,ARS.[DateSaved]
				,ARS.[RootCausePrimary]
				,ARS.CloseDate
				,ROW_NUMBER() 
					OVER (
						PARTITION BY D.[IndividualDate], ARS.AccountId
						ORDER BY 
							ParentStatusOrder ASC
							,CASE WHEN ParentStatus != 'Lost' THEN 2
								  WHEN CloseDate IS NULL THEN 1
								  ELSE 0
								  END ASC
							,CASE WHEN ParentStatus != 'Lost' THEN 1
								  ELSE CloseDate
								  END ASC
							,CloseDate DESC 
							,CreatedDate ASC
						) AS RowNo
			FROM 
				(
					SELECT --ARS.[AccountID]
						  ARS.[CreatedDate]
						  ,ARS.[DateLost]
						  ,ARS.[DateSaved]
						  ,ARS.[M5DBAccountId] AS AccountId
						  ,ARS.[RootCausePrimary]
						  ,ARS.[Status]
						  ,CASE WHEN lower(ARS.[Status]) LIKE 'lost%' THEN 'Lost'
								WHEN lower(ARS.[Status]) LIKE 'saved%' THEN 'Saved'
								ELSE 'At Risk' 
								END AS ParentStatus
						  ,CASE WHEN lower(ARS.[Status])LIKE 'lost%'  THEN DateLost
								 WHEN lower(ARS.[Status]) LIKE 'saved%' THEN DateSaved
								 ELSE NULL 
								 END AS CloseDate
						  ,CASE WHEN lower(ARS.[Status]) LIKE 'lost%' THEN 1
								 WHEN lower(ARS.[Status]) LIKE 'saved%' THEN 3
								 ELSE 2
								 END  AS ParentStatusOrder
						  --,CASE WHEN ARS.DateLost >= ARS.DateSaved OR ARS.DateSaved IS NULL THEN ARS.DateLost
						--		ELSE ARS.DateSaved 
						--		END As CloseDate
						  ,ARS.ID
					  FROM sfdc.VwARS ARS
					  LEFT JOIN FinanceBI.company.VwAccount A
						ON ARS.[M5DBAccountID] = A.[Ac Id]
					  WHERE --M5DBAccountID IS NOT NULL
					        -- MW 02202018 US only
							isnumeric(ARS.M5DBAccountID) =1
		
				) ARS
			FULL OUTER JOIN
				(
					SELECT DISTINCT [Date] As 'IndividualDate'
					FROM FinanceBI.enum.DimDate
					WHERE --[Date] = CAST(GETDATE() AS Date)
					
						([Date] >= dateadd(d,-60,GETDATE())
						AND [Date] <= GETDATE()
						AND (DATEPART(dw, [Date]) = 6 OR [Date] = CAST(GETDATE() AS Date)))
						OR 
						([Date] >= dateadd(yy,-2, GETDATE())
						AND [Date] < GETDATE()
						AND DATEPART(dd, [Date]) = 1)  -- First day of month
						OR 
						([Date] >= dateadd(yy,-2, GETDATE())
						AND [Date] < GETDATE()
						AND [Date] = Eomonth([Date]) )-- Last Day of Month
				  ) D
				ON D.[IndividualDate] >= CAST(ARS.[CreatedDate] AS DATE)
					--AND ((ParentStatus = 'Saved' 
					--		AND D.[IndividualDate] <= dateadd(d, 7, ARS.DateSaved))
					--	OR ParentStatus != 'Saved')
			WHERE D.IndividualDate IS NOT NULL
)



SELECT *
FROM CTE
WHERE RowNo = 1
	

