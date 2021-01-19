CREATE VIEW [MWSandbox].[VwContractInfo]
AS
-- MW 11212017 Contract Info for Santana
SELECT x.AccountId
	,x.[StartDate]
	,datediff(day, x.[StartDate], getdate()) AS DaysSinceStart
	,x.[EndDate]
	,datediff(day, getdate(), x.[EndDate]) AS DaysUtilEnd
	,x.ContractType
FROM (
	SELECT *
	FROM (
		SELECT CTH.AccountId
			-- ,DateDiff(month, CTD.StartDate, CTD.EndDate)+1 TermMonths
			,CTD.[StartDate]
			,CTD.[EndDate]
			,ACT.[Name] AS ContractType
		FROM [$(FinanceBI)].company.ContractTermDetail CTD
		INNER JOIN [$(FinanceBI)].company.ContractTermHeader CTH ON CTH.Id = CTD.AccountContractHeaderId
		INNER JOIN [$(FinanceBI)].enum.AccountContractType ACT ON ACT.Id = CTD.ContractTypeId
		LEFT JOIN [$(FinanceBI)].sales.Contract C ON C.Id = CTD.SalesContractId
		INNER JOIN (
			SELECT Id
				,EndDate
				,row_number() OVER (
					PARTITION BY AccountContractHeaderId ORDER BY EndDate DESC
					) rn
			FROM [$(FinanceBI)].company.ContractTermDetail CTD2
			-- MW 12032019  Only look at start dates after today
			WHERE StartDate <= getdate()
			) CTDM ON CTDM.Id = CTD.Id
			AND CTDM.rn = 1
		) foo
	) x