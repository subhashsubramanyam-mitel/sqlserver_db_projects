



-- =============================================
-- Author:		Tarak Goradia
-- Create date: May 15, 2018
-- Description:	 return MRR/NRR records for REVISED MRR Cube
-- Changes:
-- SS	2020-11-02	Included UNION ALL with expinvoice.VwIncrMRRbase_EX, Ln 295 as fix to get MRR Delta for future month as per MW
-- SS	2020-12-02  Added filter InvoiceMonth = First of Next Month as per MW
-- =============================================
CREATE FUNCTION [invoice].[UfnMRRNRR_2] (
	@FromDate DATE
	,-- includes
	@ToDate DATE -- excludes
	)
RETURNS TABLE
AS
RETURN (
		SELECT MB.AccountId
			,LocationId
			,OrderProjectManagerId
			,OrderCreatedByPersonId
			,orderedById
			,OrderSalesPersonId
			,[Ac Team]
			,AccountManagerId
			,enum.UfnMRRCategory(MB.Category, MB.OrderTypeId, MB.MasterOrderTypeId, MB.MonthMRRFirstInvoiced, coalesce(A.Num, 0), MB.InvoiceMonth) [MRR Category]
			-- May 4, 2017
			/*
		CASE 
			WHEN MB.Category = 'Install' and MB.OrderTypeId = 2 
				THEN 'Add' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is null and MB.OrderTypeId = 2 
				THEN 'Add' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is null and MB.OrderTypeId <> 2 
				THEN 'Install' 
			WHEN MB.Category = 'Anomaly' and MB.MonthMRRFirstInvoiced is not null  
				THEN 'Reinstated' 
			WHEN MB.Category = 'Close' and coalesce(A.Num,0) = 0
				THEN 'Cancel - Ac Close' 
			WHEN MB.Category = 'Close' and coalesce(A.Num,0) > 0
				THEN 'Cancel - Downsize'
			ELSE MB.Category 
		END [MRR Category],  -- May 4, 2017 */
			,[MRR Prev] * EX.EXCHRATE / 100 [MRR Prev]
			,[MRR Expected] * EX.EXCHRATE / 100 [MRR Expected]
			,[MRR Delta] * EX.EXCHRATE / 100 [MRR Delta]
			,[NRR] * EX.EXCHRATE / 100 [NRR]
			,CC.CurrencyCode
			,[MRR Prev] [MRR Prev LC]
			,[MRR Expected] [MRR Expected LC]
			,[MRR Delta] [MRR Delta LC]
			,NRR [NRR LC]
			,InvoiceDay
			,MB.InvoiceMonth
			,ServiceId
			,ProductId
			,OrderId
			,OrderTypeId
			,[Order Date Created]
			,ServiceClassId
			,DateSvcLiveActual
			,ServiceStatusId
			,BillingStage
			,BookToBillDays
			,CASE 
				WHEN MB.Category IN ('Close')
					THEN 0
				ELSE 1
				END AS Quantity
			,CASE 
				WHEN MB.Category IN (
						'Install'
						,'Anomaly'
						,'NRR-Only'
						)
					THEN 1
				WHEN MB.Category IN ('Close')
					THEN - 1
				ELSE 0
				END AS DeltaQuantity
			,MB.QMRR
			,InvoiceGroupId
			,[Loc SeatSizeSegmentId]
			,[Loc PlannedSeatSizeSegmentId]
			,[Ac SeatSizeSegmentId]
			,[Ac PlannedSeatSizeSegmentId]
			,[Ac PrevMonthSeatSizeSegmentId]
			,SfdcTerritoryId
			,SalesContractId
			,CASE 
				WHEN P.[Prod Category] = 'Profiles'
					AND P.[Prod Name] <> 'MiCloud Connect IP Phone User'
					THEN CASE 
							WHEN MB.Category IN (
									'Install'
									,'Anomaly'
									,'NRR-Only'
									)
								THEN 1
							WHEN MB.Category IN ('Close')
								THEN - 1
							ELSE 0
							END
				ELSE 0
				END AS DeltaQuantity_Seats
			,CASE 
				WHEN (
						P.[Prod Category] = 'Profiles'
						AND P.[Prod Name] <> 'MiCloud Connect IP Phone User'
						)
					THEN 1
				ELSE 0
				END AS Quantity_Seats
		FROM (
			SELECT A.[Ac Id] AS AccountId
				,L.[Loc Id] AS LocationId
				,CASE 
					WHEN s.OrderProjectManagerId IS NOT NULL
						THEN s.OrderProjectManagerId
					ELSE s.OrderCreatedByPersonId
					END AS OrderProjectManagerId
				,s.OrderCreatedByPersonId
				,s.orderedById
				,s.OrderSalesPersonId
				,s.ClosedByPersonId
				,A.[Ac Team]
				,A.AccountManagerId
				,IA.Category
				,IA.LastCharge [MRR Prev]
				,IA.CurCharge [MRR Expected]
				,IA.MRRDelta [MRR Delta]
				,NR.OneTimeCharge NRR
				,IA.InvoiceDay
				,IA.InvoiceMonth
				,IA.ServiceId
				,S.ProductId
				,coalesce(o.Id, S.OrderId) AS OrderId
				,-- Have some Order Id, March 10, 2016
				coalesce(o.OrderTypeId, s.OrderTypeId) OrderTypeId
				,mo.OrderTypeId MasterOrderTypeId
				,cast(o.DateCreated AS DATE) AS [Order Date Created]
				,s.ServiceClassId
				,s.DateSvcLiveActual
				,s.ServiceStatusId
				,s.BillingStage
				,enum.UfnBookToBillDays(s.BillingStage, s.DateSvcCreated, s.DateBillingValidFrom, s.DateSvcLiveScheduled) BookToBillDays
				,CASE 
					WHEN IA.InvoiceMonth = M.NextMonth
						THEN IA.CurCharge
					WHEN IA.InvoiceMonth = DateAdd(month, 2, D.Quarter)
						THEN IA.CurCharge
					ELSE 0.0
					END QMRR
				,S.MonthMRRFirstInvoiced
				,IA.CurrencyId
				,L.InvoiceGroupId
				,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles]) [Loc SeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles] + L.[NumPendingProfiles]) [Loc PlannedSeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfiles]) [Ac SeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfiles] + A.[NumPendingProfiles]) [Ac PlannedSeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfilesLastMonth]) [Ac PrevMonthSeatSizeSegmentId]
				,A.SfdcTerritoryId
				,CTD.SalesContractId
			FROM invoice.MonthlyIACP IA
			INNER JOIN oss.VwServiceProduct_Ranked_EX S ON s.ServiceId = IA.ServiceId
				AND (
					s.productId = coalesce(IA.curProductId, IA.LastProductId)
					-- or (IA.InvoiceMonth >= S.DateBillingValidFrom and IA.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
					)
				AND S.RankNum = 1
			LEFT JOIN company.VwLocation L WITH (NOLOCK) ON L.[Loc Id] = s.LocationId
			LEFT JOIN company.VwAccount A WITH (NOLOCK) ON A.[Ac Id] = s.AccountId
			LEFT JOIN oss.[Order] o WITH (NOLOCK) ON o.id = coalesce(IA.OrderId, S.orderId) -- some order id May 4, 2017
			LEFT JOIN oss.[Order] mo WITH (NOLOCK) ON mo.id = o.MasterOrderId -- Master Order, May 4, 2017
			LEFT JOIN invoice.MonthlyNRR NR WITH (NOLOCK) ON NR.ServiceId = IA.ServiceId
				AND NR.InvoiceMonth = IA.InvoiceMonth
				AND NR.AssociatedMRRCategory = IA.Category
			LEFT JOIN enum.DimDate D ON D.DATE = IA.InvoiceMonth
			LEFT JOIN (
				SELECT SalesContractId
				FROM company.ContractTermDetail
				GROUP BY SalesContractId
				) CTD ON CTD.SalesContractId = O.SalesContractId
			INNER JOIN (
				SELECT DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
				) M ON 1 = 1
			WHERE IA.InvoiceMonth >= @FromDate
				AND IA.InvoiceMonth < @ToDate
			
			UNION ALL
			
			SELECT A.[Ac Id] AS AccountId
				,L.[Loc Id] AS LocationId
				,CASE 
					WHEN s.OrderProjectManagerId IS NOT NULL
						THEN s.OrderProjectManagerId
					ELSE s.OrderCreatedByPersonId
					END AS OrderProjectManagerId
				,s.OrderCreatedByPersonId
				,s.orderedById
				,s.OrderSalesPersonId
				,s.ClosedByPersonId
				,A.[Ac Team]
				,A.AccountManagerId
				,CASE 
					WHEN NR.OneTImeCharge < 0
						THEN 'Install-Credit'
					ELSE 'NRR-Only'
					END
				,0.0 [MRR Prev]
				,0.0 [MRR Expected]
				,0.0 [MRR Delta]
				,NR.OneTimeCharge NRR
				,NR.InvoiceMonth AS InvoiceDay
				,NR.InvoiceMonth
				,NR.ServiceId
				,S.ProductId
				,coalesce(o.Id, S.OrderId) AS OrderId
				,-- Have some Order Id, March 10, 2016
				coalesce(o.OrderTypeId, s.OrderTypeId) OrderTypeId
				,mo.OrderTypeId MasterOrderTypeId
				,cast(o.DateCreated AS DATE) AS [Order Date Created]
				,s.ServiceClassId
				,s.DateSvcLiveActual
				,s.ServiceStatusId
				,s.BillingStage
				,enum.UfnBookToBillDays(s.BillingStage, s.DateSvcCreated, s.DateBillingValidFrom, s.DateSvcLiveScheduled) BookToBillDays
				,0.0 QMRR
				,S.MonthMRRFirstInvoiced
				,NR.CurrencyId
				,L.InvoiceGroupId
				,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles]) [Loc SeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](L.[Loc NumProfiles] + L.[NumPendingProfiles]) [Loc PlannedSeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfiles]) [Ac SeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfiles] + A.[NumPendingProfiles]) [Ac PlannedSeatSizeSegmentId]
				,enum.[UfnSeatSizeSegmentId](A.[NumProfilesLastMonth]) [Ac PrevMonthSeatSizeSegmentId]
				,A.SfdcTerritoryId
				,CTD.SalesContractId
			FROM invoice.MonthlyNRR NR
			INNER JOIN oss.VwServiceProduct_Ranked_EX S ON s.ServiceId = NR.ServiceId
				AND (
					s.productId = NR.ProductId
					-- or (NR.InvoiceMonth >= S.DateBillingValidFrom and NR.InvoiceMonth  <coalesce(S.DateBillingValidTo, '2099-01-01'))
					)
				AND S.RankNum = 1
			LEFT JOIN company.VwLocation L WITH (NOLOCK) ON L.[Loc Id] = s.LocationId
			LEFT JOIN company.VwAccount A WITH (NOLOCK) ON A.[Ac Id] = s.AccountId
			LEFT JOIN oss.[Order] o WITH (NOLOCK) ON o.id = coalesce(NR.OrderId, s.OrderId) -- some order id May 4, 2017
			LEFT JOIN oss.[Order] mo WITH (NOLOCK) ON mo.id = o.MasterOrderId -- Master Order, May 4, 2017
			LEFT JOIN enum.DimDate D ON D.DATE = NR.InvoiceMonth
			LEFT JOIN (
				SELECT SalesContractId
				FROM company.ContractTermDetail
				GROUP BY SalesContractId
				) CTD ON CTD.SalesContractId = O.SalesContractId
			INNER JOIN (
				SELECT DateAdd(month, 1, dbo.UfnFirstOfMonth(getdate())) NextMonth
				) M ON 1 = 1
			WHERE NR.AssociatedMRRCategory IS NULL
				AND NR.InvoiceMonth >= @FromDate
				AND NR.InvoiceMonth < @ToDate
			
			UNION ALL -- EXPECTED INVOICE
			
			SELECT IR.*
			FROM expinvoice.VwIncrMRRNRRbase_EX_2 IR
			INNER JOIN (
				SELECT dbo.UfnFirstOfMonth(DateAdd(month, 1, getdate())) NextMonth
				) A ON 1 = 1
			WHERE InvoiceMonth = A.NextMonth
				AND A.NextMonth < @ToDate
			) MB
		LEFT JOIN (
			SELECT AccountId
				,InvoiceMonth
				,coalesce(SUM([MRR Expected]), 0.0) ActiveMRR
				,coalesce(COUNT(1), 0) Num
			FROM invoice.VwIncrMRRbase _EX
			WHERE Category NOT IN (
					'Close'
					,'NRR-Only'
					)
			GROUP BY AccountId
				,InvoiceMonth
			
			-- BEGIN -- Added by SS as per MW, 2020-10-03
			UNION ALL

			SELECT AccountId
				,InvoiceMonth
				,coalesce(SUM([MRR Expected]), 0.0) ActiveMRR
				,coalesce(COUNT(1), 0) Num
			FROM expinvoice.VwIncrMRRbase_EX
			WHERE Category NOT IN (
					'Close'
					,'NRR-Only'
					)
				AND InvoiceMonth = DATEADD(m, DATEDIFF(m, -1, current_timestamp), 0) -- SS added filter InvoiceMonth = First of Next Month as per MW
			GROUP BY AccountId
				,InvoiceMonth

			-- END	-- Added by SS as per MW, 2020-10-03
			) A ON A.AccountId = MB.AccountId
			AND A.InvoiceMonth = MB.InvoiceMonth
		INNER JOIN enum.CurrencyCode CC ON CC.Id = coalesce(MB.CurrencyId, 1)
		INNER JOIN ax.VwExchRatePeriod EX ON EX.CURRENCYCODE = CC.CurrencyCode
			AND MB.InvoiceDay >= EX.DateFrom
			AND MB.InvoiceDay < EX.DateTo
		LEFT JOIN enum.VwProduct P ON MB.ProductId = P.[Prod Id]
		)
