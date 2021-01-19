













CREATE VIEW [Tableau].[VwContractLookup]
AS
-- MW 05132019 include add location contracts
SELECT a.*
	,row_Number() OVER (
		PARTITION BY a.ContractNumber ORDER BY a.DateCreated ASC
		) rn
FROM (
	SELECT a.ContractNumber
		,a.StartDate
		,a.DateCreated
		,a.ContractType
		,NULL AS Contracts
		--, row_Number() Over (partition by ContractNumber order by DateCreated desc) rn
		,CASE 
			WHEN a.ContractType = 'New Customer'
				THEN convert(VARCHAR(10), a.ProfileAmount)
			ELSE '0'
			END AS ContractProfileAmount
		,convert(VARCHAR(15), Id) AS ContractId
		,a.AccountId
		,a.CommitmentDate
		,a.BusinessTermVersion
	FROM company.VwContractDetail a
	
	UNION ALL
	
	SELECT a.ContractNumber
		,StartDate
		,DateCreated
		,ContractType
		,contracts
		,ContractProfileAmount
		,ContractId
		,a.AccountId
		,a.CommitmentDate
		,BusinessTermVersion
	FROM (
		SELECT a.ContractNumber
			,NULL AS StartDate
			,a.DateCreated AS DateCreated
			,'Add Location' AS ContractType
			,count(*) AS contracts
			--,1 as  rn
			,sum(isnull(a.ProfileAmount, 0)) AS ContractProfileAmount
			,'L' + convert(VARCHAR(15), a.Id) AS ContractId
			,a.AccountId
			,a.CommitmentDate
			,v.Name AS BusinessTermVersion
			,row_Number() OVER (
				PARTITION BY a.ContractNumber ORDER BY a.DateCreated DESC
				) rn
		FROM sales.Contract a
		LEFT OUTER JOIN [enum].[ContractBusinessTermVersion] v ON a.BusinessTermVersion = v.Id
		LEFT OUTER JOIN company.ContractTermDetail c ON a.Id = c.SalesContractId
		WHERE a.ContractTypeId = 2
			AND c.Id IS NULL
			AND
			-- MW 09112020 check deleted
			isnull(c.isDeleted, 0) = 0
		GROUP BY ContractNumber
			,a.DateCreated
			,'L' + convert(VARCHAR(15), a.Id)
			,a.AccountId
			,a.CommitmentDate
			,v.Name
		) a
	WHERE rn = 1
	) a
