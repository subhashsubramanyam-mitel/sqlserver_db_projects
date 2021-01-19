








--DROP VIEW ALSandbox.VwMidMonthMRRDelta

CREATE VIEW [ALSandbox].[VwMidMonthMRRDelta]	AS

SELECT T.AccountId
	,ServiceMonth
	,CASE WHEN [MRR Category] = 'Downsize'
			AND PipelineStage = 'Pending'
			AND SUM(MRR) < 0
			AND SUM(MRR)*-1 >= A.[Ac ActiveMRR]*0.95
				-- Recategorize Downsizes as Ac Close if the sum of the orders is >= 95% of Ac Active MRR
		THEN 'Ac Close'
		ELSE [MRR Category] END AS [MRR Category]
	,PipelineStage
	,SUM(dqty) as DeltaQuantity
	,SUM(MRR) AS MRR
	,SUM(MRR_LC) as MRR_LC
	,Region
	,[Ac Name]
	,SUM(dqty_s) as DeltaQuantity_Seats
	,OrderCloseReason
	, SUM(qtyseats) as QuantitySeats
	,OrderId as CloseOrderId
FROM
	(
	-- Forecasted Installs and Adds 
	SELECT [AccountId],  
		CASE WHEN BillingStage = 'Unscheduled'
			THEN DATEADD(d, -1*datepart(d, GETDATE())+1, cast(GETDATE() AS Date))
			ELSE DATEADD(d, -1*datepart(d, DateForecast)+1, DateForecast )
			END as 'ServiceMonth',
		CASE WHEN  MasterOrderTypeId = 6	THEN 'Migration'
			 WHEN OrderTypeId IN (0,9) THEN 'Install'
			ELSE 'Add' 
			END AS 'MRR Category',
		CASE WHEN [BillingStage] = 'Unscheduled' THEN 'Overdue'
			 WHEN BillingStage != 'Unscheduled' AND Built = 1 THEN 'Forecasted - Built'
			 ELSE 'Forecasted - Unbuilt'
			END AS 'PipelineStage',

			0 as dqty
		,SUM([MonthlyCharge]) as 'MRR'
		,SUM([MonthlyCharge_LC]) as 'MRR_LC'
		,0 as dqty_s
		,null as OrderCloseReason
		,0 as qtyseats
		,null as OrderId

	  FROM 
			(SELECT BillingStage
				,SP.AccountId
				,SP.OrderTypeId
				,MO.OrderTypeId AS MasterOrderTypeId
				,coalesce(DateSvcLiveScheduled, L.DateLiveForecast) AS DateForecast
				,SP.MonthlyCharge
				,SP.MonthlyCharge_LC
				,CASE WHEN B.ServiceBundleId IS NOT NULL THEN 1
					  WHEN SP.ServiceStatusId = 27 THEN 1 
					  ELSE 0 
					  END AS Built
			FROM [oss].[VwServiceProduct_EX] SP
			LEFT JOIN FinanceBI.company.VwLocation L
				ON SP.LocationId = L.[Loc Id]
			LEFT JOIN
				(SELECT DISTINCT ServiceBundleId
				FROM oss.VwServiceProduct_EX SP1
				LEFT JOIN enum.VwProduct P
					ON SP1.ProductId = P.[Prod Id]
				WHERE ServiceStatusId = 27
					AND P.[Prod Id] = 355 -- Connect Cloud IP Phone User
					AND ServiceBundleId IS NOT NULL
				) B
				ON B.ServiceBundleId = SP.ServiceId
			
			-- Find open Migration Orders 
			LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
				ON SP.OrderId = O.OrderId
			LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
				ON MO.OrderId = O.MasterOrderId
			 WHERE [BillingStage] IN ('Forecasted', 'Unscheduled')
				AND SP.[OrderTypeId] IN (0, 2, 9) -- Initial, Add, Linked Add
				AND (DateSvcLiveScheduled IS NOT NULL OR 
						L.DateLiveForecast IS NOT NULL)
				AND IsMRRZero = 'NonZero'
			) A
	  GROUP BY [AccountId], [OrderTypeId], [BillingStage], DateForecast,
		DATEADD(d,-1*datepart(d,DateForecast )+1,DateForecast )
		,Built
		,MasterOrderTypeId

	UNION ALL

	-- MRR Delta Values similar to CloudMRR
	SELECT CloudMRR.[AccountId], 
		dateadd(m,-1, [InvoiceMonth]) as ServiceMonth,
		CASE WHEN CloudMRR.[MRR Category] like 'Migrate%' AND dateadd(m,-1, [InvoiceMonth]) < '20170630' THEN 'Price Change'
			ELSE P.ParentMRRCategory
			END AS MRRCategory,

		CASE WHEN CloudMRR.[MRR Category] = 'Reinstated' THEN 'Reinstated'
												ELSE 'Secured' 
			 END AS 'PipelineStage' 
		,SUM(CloudMRR.DeltaQuantity) as dqty
		,SUM([MRR Delta]) as 'MRR'
		,SUM([MRR Delta LC]) as 'MRR_LC'
		,SUM(DeltaQuantity_Seats)  as dqt_s
		,O.OrderCloseReason
		,CASE WHEN (pr.[Prod Category] = 'Profiles'
			AND pr.[Prod Name] <> 'MiCloud Connect IP Phone User')
			Then SUM(CloudMRR.Quantity) else 0 END as qtyseats

	 ,null as OrderId
	   FROM [invoice].[VwMatVwIncrMRRNRR_EX_2] as CloudMRR
	 -- FROM [Tableau].[VwIncrMRRNRR_EX]  as CloudMRR
	  	LEFT OUTER JOIN [oss].[VwOrder] AS O
		ON CloudMRR.[OrderId] = O.[OrderId]
	  LEFT JOIN FinanceBI.ALSandbox.MRRCategoryRollUp P
		ON CloudMRR.[MRR Category] = P.[MRR Category]
	 LEFT JOIN enum.VwProduct pr on CloudMRR.ProductId = pr.[Prod Id]
	  WHERE [CloudMRR].[MRR Category] NOT IN ('NoChange', 'NRR-Only', 'Install-Credit')
		AND [CloudMRR].[InvoiceMonth] >= DATEadd(month,-24,GETDATE())
	  GROUP BY CloudMRR.[AccountId],  dateadd(m,-1, [InvoiceMonth]), CloudMRR.[MRR Category],P.ParentMRRCategory, O.OrderCloseReason
				,pr.[Prod Category], pr.[Prod Name]
	UNION ALL

	-- Pending Orders for Closes, Downsizes, and Prices Changes
	SELECT D.[OrderAccountId] AS AccountId
		,CASE WHEN D.[OrderTypeId] = 4 
						AND DATEADD(d,-1*datepart(d,GETDATE())+1,cast(GETDATE() AS Date)) >= DATEADD(m,-1,DATEADD(d,-1*datepart(d,D.DateLiveScheduled)+1,D.DateLiveScheduled)) 
				THEN DATEADD(d,-1*datepart(d,GETDATE())+1,cast(GETDATE() AS Date))
			  WHEN D.[OrderTypeId] = 4 
						AND DATEADD(d,-1*datepart(d,GETDATE())+1,cast(GETDATE() AS Date)) < DATEADD(m,-1,DATEADD(d,-1*datepart(d,D.DateLiveScheduled)+1,D.DateLiveScheduled)) 
				THEN DATEADD(m,-1,DATEADD(d,-1*datepart(d,D.DateLiveScheduled)+1,D.DateLiveScheduled))
			  WHEN D.[OrderTypeId] = 5
				THEN DATEADD(m,-2,DATEADD(d,-1*datepart(d,D.DateLiveScheduled)+1,D.DateLiveScheduled))
			END as 'ServiceMonth'
		,CASE 
			WHEN MO.OrderTypeId = 6 THEN 'Migration'
			WHEN D.[OrderTypeId] = 4	THEN 'Downsize' 
			-- All Close orders categorized as Downsize initially, recategorized once they can be compared to Ac Active MRR
			WHEN D.[OrderTypeId] = 5	THEN 'Price Change' 
		END AS 'MRR Category',
		'Pending' AS 'PipelineStage',
		0 as dqty
		,SUM(D.[DeltaMRR]) As 'DeltaMRR'
		,SUM(D.DeltaMRR_LC) as 'MRR_LC'
		,0 as dqt_s
		,O.OrderCloseReason
		,0 as qtyseats
		,O.OrderId
	FROM [oss].[VwOrderItemDetail_EX] AS D
	LEFT OUTER JOIN [oss].[VwOrder] AS O
		ON D.[OrderId] = O.[OrderId]
	LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
		ON MO.OrderId = O.MasterOrderId
	WHERE (D.[OrderTypeId] = 4 -- Close
			OR (D.[OrderTypeId] = 5 
					AND D.DateLiveScheduled > DATEADD(m, 1,DATEADD(d,-1*datepart(d,GETDATE())+1,CAST(GETDATE() AS DATE))) ))-- Pricing
		AND O.[OrderStatus] = 'Open'
		AND D.[ServiceStatusId] = 1 -- Active
	GROUP BY D.[OrderAccountId], D.[OrderTypeId], D.DateLiveScheduled, MO.OrderTypeId, O.OrderCloseReason, O.OrderId


	-- Tableau limitation on bullet graphs requires me to have a single pipeline stage present
	-- in each graph so that the AOP Targets display and do not multiply...

	UNION ALL

	SELECT DISTINCT--DISTINCT 6 AS AccountId, 
		A.AccountId,
		Da.[Month] AS InvoiceMonth,
		P.ParentMRRCategory AS MRRCategory,
		'AOP' AS 'Pipeline Stage',
		0 as dqty
		,0 AS MRRDelta
		,0 as MRR_LC
		,0 as dqt_s
		,null as  OrderCloseReason
		,0 as qtyseats
		,null as OrderId
	FROM 
		(SELECT MIN([Ac Id]) AS AccountId
			,Region
			,1 AS J
		FROM ALSandbox.VwAccountWRegion
		WHERE IsBillable = 1
		GROUP BY Region
		) A
	FULL OUTER JOIN 
		(SELECT  DISTINCT [Month]
			,1 AS J
		FROM FinanceBI.enum.VwAxDate D
		WHERE [Month] >= DATEadd(month,-24,GETDATE())
				AND [Month] <= Dateadd(month, 6, GETDATE())
		) Da
		ON A.J = Da.J
	FULL OUTER JOIN 
		(SELECT DISTINCT ParentMRRCategory 
			,1 AS J
		FROM FinanceBI.ALSandbox.MRRCategoryRollUp
		) P
		ON P.J = A.J
    
	) T

LEFT JOIN FinanceBI.ALSandbox.VwAccountWRegion A
	ON A.[Ac Id] = T.AccountId
-- Exclude BETA Accounts from Seth Howitt's list
LEFT JOIN ALSandbox.VwCurrentBeta B
	ON B.AccountId = T.AccountId

WHERE (B.AccountId IS NULL
			OR (PipelineStage IN ('Secured', 'AOP')
					AND eomonth(ServiceMonth) != eomonth(GETDATE()))) 
	AND A.IsBillable = 1
GROUP BY T.AccountId
	,A.[Ac ActiveMRR]
	,ServiceMonth
	,[MRR Category]
	,PipelineStage
	,Region
	,[Ac Name]
	,OrderCloseReason
	,OrderId
