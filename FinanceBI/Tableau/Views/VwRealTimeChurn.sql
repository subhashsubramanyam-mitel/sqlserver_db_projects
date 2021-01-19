Create view tableau.VwRealTimeChurn as
-- MW 02262019 Taken from MRR Delta report in ALSandbox
SELECT T.AccountId
	,OrderDate
	,ServiceMonth
	,CASE WHEN [MRR Category] = 'Downsize'
			--AND PipelineStage = 'Pending'
			AND SUM(MRR) < 0
			AND SUM(MRR)*-1 >= A.[Ac ActiveMRR]*0.95
				-- Recategorize Downsizes as Ac Close if the sum of the orders is >= 95% of Ac Active MRR
		THEN 'Ac Close'
		ELSE [MRR Category] END AS [MRR Category]
	--,PipelineStage
	,SUM(MRR) AS MRR
	,Region
	,[Ac Name]
FROM
	(

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
		--'Pending' AS 'PipelineStage' 
		 O.DateCreated as OrderDate
		,SUM(D.[DeltaMRR]) As 'MRR'
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
	GROUP BY D.[OrderAccountId], D.[OrderTypeId], D.DateLiveScheduled, MO.OrderTypeId, O.DateCreated
	) T

LEFT JOIN FinanceBI.ALSandbox.VwAccountWRegion A
	ON A.[Ac Id] = T.AccountId
 

 WHERE --(  (PipelineStage IN ('Secured', 'AOP')
--					AND eomonth(ServiceMonth) != eomonth(GETDATE()))) 
	  A.IsBillable = 1
GROUP BY T.AccountId
	,OrderDate
	,A.[Ac ActiveMRR]
	,ServiceMonth
	,[MRR Category]
	--,PipelineStage
	,Region
	,[Ac Name]
