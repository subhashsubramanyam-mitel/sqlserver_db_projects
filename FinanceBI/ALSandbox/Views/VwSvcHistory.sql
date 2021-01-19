--DROP VIEW ALSandbox.VwSvcHistory 

CREATE View ALSandbox.VwSvcHistory AS


--Grab a 90 day service history
		SELECT 	svc.[AccountId]
			,D.[IndividualDate] 
			,SUM( CASE WHEN svc.DateSvcSetToActive <= D.IndividualDate
						AND (svc.DateSvcClosed > D.IndividualDate
							OR svc.ServiceStatusId = 1 ) -- Active
						THEN svc.MonthlyCharge 
						ELSE 0 END) as 'Active MRR'

			,SUM( CASE WHEN svc.DateSvcCreated <= D.IndividualDate
						AND ((svc.DateSvcSetToActive > D.IndividualDate
								AND (svc.DateSvcVoided >= D.IndividualDate
										OR svc.DateSvcVoided IS NULL))
							OR svc.ServiceStatusId IN (16 ,27)) -- Pending, Provisioning
						THEN svc.MonthlyCharge 
						ELSE 0 END) as 'Pending MRR'

			,SUM ( CASE WHEN svc.DateSvcClosed < D.IndividualDate
						AND  svc.ServiceStatusId = 5 -- Closed
						THEN svc.MonthlyCharge 
						ELSE 0 END) as 'Closed MRR'

			,SUM ( CASE WHEN svc.DateSvcVoided < D.IndividualDate
						AND svc.ServiceStatusId = 25 -- VOID
						THEN svc.MonthlyCharge
						ELSE 0 END) As 'Voided MRR'

		FROM
			(
			SELECT sp.ServiceStatusId
						,sp.[AccountId]
						,sp.[DateSvcLiveActual]
						,sp.[DateSvcClosed]
						,sp.[MonthlyCharge]
						,sp.DateSvcSetToActive
						,sp.DateSvcCreated
						,sp.DateSvcVoided
				FROM [oss].[VwServiceProduct_EX] sp
				INNER JOIN [company].VwAccount A
					ON A.[Ac Id] = sp.[AccountId]
				WHERE A.[IsBillable] = 1
						AND sp.MonthlyCharge != 0
				
			) Svc


		FULL OUTER JOIN
			(
				SELECT CONVERT(datetime, [Date], 100) As 'IndividualDate'
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
						AND [Date] = Eomonth([Date]) )-- Last Dy of Month
		
				) D
			ON D.[IndividualDate] >= svc.DateSvcCreated
				--AND ((Svc.ServiceStatusId = 5 AND D.IndividualDate <= svc.DateSvcClosed)
				--		OR (Svc.ServiceStatusId = 25 AND D.IndividualDate <= svc.DateSvcVoided)
				--		OR svc.ServiceStatusId NOT IN (5, 25)) -- Closed, VOID
		GROUP BY  svc.AccountId, D.IndividualDate
