CREATE VIEW ALSandbox.VwPipelineIO AS 
WITH CTE AS (
	
	SELECT DateOfSnapshot
		,SUM(MonthlyCharge) AS Pipeline
	FROM oss.history_PipelineSnapshot PS
	INNER JOIN company.VwAccount A
		ON A.[Ac Id] = PS. AccountId
	LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
		ON PS.OrderId = O.OrderId
	LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
		ON MO.OrderId = O.MasterOrderId
	WHERE BillingStage IN ('Forecasted', 'Unscheduled')
		AND PS.OrderTypeId IN (0,9)
		AND A.IsBillable = 1
		--AND Eomonth(DateOfSnapshot) = DateOfSnapshot
		AND DateOfSnapshot >= '20170101'
		AND (MO.OrderTypeId IS NULL OR MO.OrderTypeId != 6)
	GROUP BY DateOfSnapshot
)

SELECT D.[Date]
	,InOut.*
	,SnapStart.Pipeline AS PipelineStart
	,SnapEnd.Pipeline AS PipelineEnd
	,SnapEnd.Pipeline-(SnapStart.Pipeline+Bookings+LinkedAdds+Voids + Installs) AS 'Pull (+) / Push (-)'

FROM enum.DimDate D
INNER JOIN CTE SnapStart 
	ON SnapStart.DateOfSnapshot = dateadd(day,-1,D.[Date]) -- Use the snapshot from the prior day to get the Pipeline Start
INNER JOIN CTE SnapEnd
	ON SnapEnd.DateOfSnapshot = D.[Date] -- Use the snapshot from the current day to get the Pipeline End
LEFT JOIN
(
	SELECT [DateOfActivity]
		,SUM(CASE WHEN RecordType = 'Booking' THEN MRR ELSE 0 END) AS Bookings
	
		,SUM(CASE WHEN RecordType = 'Initial Order' THEN MRR ELSE 0 END) AS IntialOrder
		,SUM(CASE WHEN RecordType = 'Linked Add Order' THEN MRR ELSE 0 END) AS LinkedAdds
		,-1*SUM(CASE WHEN RecordType = 'Voids' THEN MRR ELSE 0 END) AS Voids
		,-1*SUM(CASE WHEN RecordType = 'Installs' THEN MRR ELSE 0 END) AS Installs
		FROM
		(

		SELECT [RecordType], [DateOfActivity], [Ac Name], [MRR], [ACCT ID], [SFDC ACCT ID], [Region]
			FROM (
			SELECT 
				'Booking'				AS [RecordType],
				CloseDate				AS [DateOfActivity],
				EstimatedMRR			AS [MRR],
				AM.M5dbAccountId		AS [ACCT ID],
				[AccountId]				AS [SFDC ACCT ID]
			FROM ALSandbox.VwOppKPI O
			LEFT JOIN sfdc.VwAccountMap AM
				ON O.AccountId COLLATE SQL_Latin1_General_CP1_CS_AS 
					= AM.SfdcId COLLATE SQL_Latin1_General_CP1_CS_AS 
			WHERE (RecordType IS NULL OR RecordType != 'Secondary')
				AND EstimatedMRR > 0 
				AND (Stage IS NULL OR Stage != 'Closed Won- MSA')
				AND ([Type] IS NULL OR [Type] != 'Moves, Splits, Changes')
				AND Won = 'true'
				-- Narrow Hosted Bookings to population that will hit BOSS
				AND left(Region,2) = 'US'
				AND (SubType IS NULL OR  (lower(SubType) NOT LIKE '%flex%'
											AND lower(SubType) NOT LIKE '%onsite%'
											AND lower(SubType) NOT LIKE '%premise%'
											AND lower(SubType) NOT LIKE '%private%'
											))

			UNION ALL

			SELECT 
				'Initial Order'			AS RecordType,
				[DateSvcCreated]		AS [DateOfActivity],
				[MonthlyCharge]			AS [MRR],
				SP.[AccountId]				AS [ACCT ID],
				NULL					AS [SFDC ACCT ID]
			FROM [oss].[VwServiceProduct_EX] SP
			INNER JOIN company.VwAccount A
				ON A.[Ac Id] = SP. AccountId
			LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
				ON SP.OrderId = O.OrderId
			LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
				ON MO.OrderId = O.MasterOrderId
			WHERE SP.[OrderTypeId] = 0 
				AND A.IsBillable = 1
				AND [MonthlyCharge] != 0
				AND (MO.OrderTypeId IS NULL OR MO.OrderTypeId != 6)
			UNION ALL

			SELECT 
				'Installs'				AS RecordType,
				[DateSvcSetToActive]	AS [DateOfActivity],
				[MonthlyCharge]			AS [MRR],
				SP.[AccountId]				AS [ACCT ID],
				NULL					AS [SFDC ACCT ID]
			FROM [oss].[VwServiceProduct_EX] SP
			INNER JOIN company.VwAccount A
				ON A.[Ac Id] = SP. AccountId
			LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
				ON SP.OrderId = O.OrderId
			LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
				ON MO.OrderId = O.MasterOrderId
			WHERE [DateSvcSetToActive] IS NOT NULL
				AND [MonthlyCharge] != 0
				AND A.IsBillable = 1
				AND SP.OrderTypeId IN (0,9) -- Initial, Linked Add
				AND (MO.OrderTypeId IS NULL OR MO.OrderTypeId != 6)

			UNION ALL

			SELECT 
				'Linked Add Order'			AS RecordType,
				[DateSvcCreated]		AS [DateOfActivity],
				[MonthlyCharge]			AS [MRR],
				SP.[AccountId]				AS [ACCT ID],
				NULL					AS [SFDC ACCT ID]
			FROM [oss].[VwServiceProduct_EX] SP
			INNER JOIN company.VwAccount A
				ON A.[Ac Id] = SP. AccountId
			LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
				ON SP.OrderId = O.OrderId
			LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
				ON MO.OrderId = O.MasterOrderId
			WHERE SP.[OrderTypeId] = 9 -- Linked Add
				AND A.IsBillable = 1
				AND [MonthlyCharge] != 0
				AND (MO.OrderTypeId IS NULL OR MO.OrderTypeId != 6)


			UNION ALL

			SELECT 
				'Voids'			AS RecordType,
				[DateSvcVoided]		AS [DateOfActivity],
				[MonthlyCharge]			AS [MRR],
				SP.[AccountId]				AS [ACCT ID],
				NULL					AS [SFDC ACCT ID]
			FROM [oss].[VwServiceProduct_EX] SP
			INNER JOIN company.VwAccount A
				ON A.[Ac Id] = SP. AccountId
			LEFT JOIN (SELECT OrderId, MasterOrderId FROM oss.VwOrder WHERE MasterOrderId IS NOT NULL) O
				ON SP.OrderId = O.OrderId
			LEFT JOIN (SELECT OrderId, OrderTypeId FROM oss.VwOrder WHERE OrderTypeId = 6) MO
				ON MO.OrderId = O.MasterOrderId
			WHERE SP.[OrderTypeId] IN (0,9) -- Initial, Linked Add
				AND ServiceStatusId = 25 -- Void
				AND A.IsBillable = 1 
				AND [MonthlyCharge] != 0
				AND (MO.OrderTypeId IS NULL OR MO.OrderTypeId != 6)

			) as x

		LEFT JOIN [ALSandbox].[VwAccountWRegion] as al
			ON al.[Ac Id] = x.[ACCT ID]

		) y
	WHERE [DateOfActivity] >= '20170101'
	GROUP BY [DateOfActivity]
--	ORDER BY eomonth([Date])
) InOut
	ON D.[Date] = InOut.[DateOfActivity]


--ORDER BY D.[Date]

