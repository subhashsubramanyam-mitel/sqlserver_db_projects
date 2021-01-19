CREATE VIEW ALSandbox.VwOrderAndBooking AS


SELECT OrderSummary.*
	,Opp.[Date Closed]
	,Opp.[Amount Won]
	,Opp.[# Profiles]
	,Opp.[Type] AS OppType
FROM 
	(
	SELECT O.[OrderId]
		,O.[OrderTypeId]
		,O.[LinkedOrderId]
		,O.[OrderStatus]
		,O.[AccountId]
		,O.[DateCreated] As DateOrderCreated
		,O.ContractNumber
		,A.[Platform] AS AcPlatform
		,A.Cluster AS AcInstance
		,A.[Ac Name]
		,SUBSTRING(O.ContractNumber, PATINDEX('%[^0]%', O.ContractNumber+'.'), LEN(O.ContractNumber)) AS ContractNumberTrim
		,CASE O.OrderTypeId WHEN 0 THEN O.DateCreated
				WHEN 9 THEN LinkedO.DateCreated
				END AS DateInitialOrderCreated 


	FROM [oss].[VwOrder] O
	LEFT JOIN [oss].[VwOrder] LinkedO
			ON O.LinkedOrderId = LinkedO.OrderId
	LEFT JOIN FinanceBI.company.VwAccount A
		ON A.[Ac Id] = O.AccountId
	WHERE O.OrderTypeId IN (0, 9) -- Initial and Linked Add
			AND O.OrderStatus NOT IN ('Void', 'Duplicate')
			AND YEAR(O.DateCreated) >= 2015
			AND A.IsBillable = 1
	) OrderSummary



LEFT JOIN FinanceBI.ALSandbox.VwSfdcOpportunityWSecondary Opp
	ON Opp.OppNumberTrim = OrderSummary.ContractNumberTrim COLLATE SQL_Latin1_General_CP1_CI_AS
		AND OrderSummary.AccountId = Opp.LocalBOSSAccountId
WHERE (BOSS_Instance = 'US' OR BOSS_Instance IS NULL)



