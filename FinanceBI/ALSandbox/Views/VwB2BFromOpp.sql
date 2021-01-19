
CREATE VIEW ALSandbox.VwB2BFromOpp AS 

SELECT *
	,B2B*MonthlyCharge AS B2BxMRR
	,C2B*MonthlyCharge AS C2BxMRR
	,B2C*MonthlyCharge AS B2CxMRR
FROM
	(SELECT *
		,DateDIFF(d, [Date Closed], DateForecasted) AS B2B
		,DateDIFF(d, DateOrderCreated, DateForecasted) AS C2B
		,DateDiff(d, [Date Closed], DateOrderCreated) AS B2C

		FROM	
			(
				SELECT SP.ServiceId
					,SP.MonthlyCharge
					,SP.ProductId
					,SP.ServiceStatusId
					,coalesce(SP.DateSvcLiveActual
								,CASE WHEN SP.DateSvcLiveScheduled >= GETDATE() THEN SP.DateSvcLiveScheduled ELSE NULL END
								,CASE WHEN L.DateLiveForecast >= GETDATE() THEN L.DateLiveForecast ELSE NULL END) 
								AS DateForecasted
					,SP.DateSvcLiveActual
					,SP.SvcPlatform
					,SP.SvcCluster AS SvcInstance
					,SP.DateSvcSetToActive
					,SP.DateSvcVoided
					,P.ProdSubCategory
					,P.[Prod Category]
					,P.[Prod Name]
					,SP.OrderProjectManagerId
					,LocationId
					,L.ConnectivityType
					,OrderAndOpp.*

				FROM FinanceBI.oss.VwServiceProduct_EX SP
				LEFT JOIN FinanceBI.enum.VwProduct P
					ON P.[Prod Id] = SP.ProductId
				LEFT JOIN FinanceBI.company.VwLocation L
					ON SP.LocationId = L.[Loc Id]

				INNER JOIN FinanceBI.ALSandbox.VwOrderAndBooking OrderAndOpp
				  ON OrderAndOpp.OrderId = SP.OrderId
				WHERE SP.IsMRRZero = 'NonZero'
			) A
		)B
--ORDER BY B2B DESC
