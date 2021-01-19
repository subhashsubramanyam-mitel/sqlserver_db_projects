
--DROP VIEW ALSandbox.VwCurrentAtRiskStatus	

CREATE VIEW [ALSandbox].[VwCurrentAtRiskStatus_Global]	AS
	
WITH cteCurrentAtRiskStatusGlobal AS (		
			SELECT S.ID
				,S.M5DBAccountId
				,S.[CreatedDate]
				,S.[Status]
				,S.[DateSaved]
				,S.[DateLost]
				,S.ID AS ARSID
				,S.ARSID As ARS_Number
				,S.[RootCausePrimary]
				,S.RootCauseSecondary
				,S.RootCauseTertiary
				,S.ParentStatus AS AcStage
				,CASE WHEN S.ParentStatus = 'Lost' THEN 1 ELSE 0 END AS LostNow
				,CASE WHEN S.ParentStatus = 'At Risk' THEN 1 ELSE 0 END AS AtRiskNow
				,S.CloseDate
				,ROW_NUMBER() 
					OVER (
						PARTITION BY S.M5DBAccountId
						ORDER BY 
							S.ParentStatusOrder ASC
							,CASE WHEN S.ParentStatus != 'Lost' THEN 2
								  WHEN S.CloseDate IS NULL THEN 1
								  ELSE 0
								  END ASC
							,CASE WHEN S.ParentStatus != 'Lost' THEN 1
								  ELSE S.CloseDate
								  END ASC
							,S.CloseDate DESC 
							,S.CreatedDate ASC
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
					  FROM sfdc.VwARS ARS
					  --LEFT JOIN FinanceBI.company.VwAccount A
						--ON ARS.[M5DBAccountID] = A.[Ac Id]
					  WHERE ARS.M5DBAccountID IS NOT NULL
						--AND M5DBAccountId NOT LIKE '%-%'
		
				)  S
	)

	SELECT *
	FROM cteCurrentAtRiskStatusGlobal 
	WHERE RowNo = 1
