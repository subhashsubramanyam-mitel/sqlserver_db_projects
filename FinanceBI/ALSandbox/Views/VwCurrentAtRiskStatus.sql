

--DROP VIEW ALSandbox.VwCurrentAtRiskStatus	

CREATE VIEW [ALSandbox].[VwCurrentAtRiskStatus]	AS
	
WITH CTE AS (		
			SELECT ARS.ID
				,ARS.M5DBAccountId
				,ARS.[CreatedDate]
				,ARS.[Status]
				,ARS.[DateSaved]
				,ARS.[DateLost]
				,ARS.ID AS ARSID
				,ARSID As ARS_Number
				,ARS.[RootCausePrimary]
				,ARS.RootCauseSecondary
				,ARS.RootCauseTertiary
				,ARS.ParentStatus AS AcStage
				,CASE WHEN ParentStatus = 'Lost' THEN 1 ELSE 0 END AS LostNow
				,CASE WHEN ParentStatus = 'At Risk' THEN 1 ELSE 0 END AS AtRiskNow
				,ARS.CloseDate
				,ARS.RelatedProduct
				, CASE when ISNUMERIC(ARS.M5DBAccountId) =1 then convert(int,ARS.M5DBAccountId) else null end as M5DBAccountId_int
				,ROW_NUMBER() 
					OVER (
						PARTITION BY ARS.M5DBAccountId
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
					SELECT ARS.[CreatedDate]
						  ,ARS.[DateLost]
						  ,ARS.[DateSaved]
						  ,ARS.[M5DBAccountId]
						  ,ARS.[RootCausePrimary]
						  ,ARS.[RootCauseSecondary]
						  ,ARS.RootCauseTertiary
						  ,ARS.[Status]
						  ,ARS.ARSID
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
						  ,ARS.ID
						  ,ARS.RelatedProduct
				 FROM sfdc.VwARS ARS
					  LEFT JOIN FinanceBI.company.VwAccount A
						ON ARS.[M5DBAccountID] = A.[Ac Id]
					  WHERE M5DBAccountID IS NOT NULL
						AND M5DBAccountId NOT LIKE '%-%'
		
				)  ARS
	)

	SELECT CTE.*
	FROM CTE 
	WHERE RowNo = 1
