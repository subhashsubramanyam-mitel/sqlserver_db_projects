

CREATE VIEW [company].[VwContractDetail]
AS
SELECT *
FROM (
	SELECT CTH.AccountId
		,CTH.Id ACHId
		,CTH.InitialCreationDate
		,CTH.InstallTermUOM
		,ISNULL(CTH.InstallTermQuantity, 0) AS InstallTermQuantity
		,CTH.InstallEnforcementDate
		,CTH.EarlyTerminationFee
		,CTD.[Id]
		,CTD.[AccountContractHeaderId]
		,CTDM.[SalesForceContractId]
		,CTD.[ContractTypeId]
		,DateDiff(month, CTDM.StartDate, CTDM.EndDate) + 1 TermMonths
		,CTDM.[StartDate]
		,CTDM.[EndDate]
		,CTD.[ProfileAmount]
		,CTD.[DownturnPercentage]
		,CTD.[ProfileLimit]
		,CTD.[MRR]
		,CTD.[RenewAutomatically]
		,CTD.[BusinessTermVersion]
		,CTD.[SalesContractId]
		,CTD.[IsActive]
		,CTD.[DateCreated]
		,CTD.[DateModified]
		,CTD.[ModifiedBy]
		,ACT.Name ContractType
		,ACT.IsRenewal
		,CTDM.NumContracts
		,coalesce(C.ContractNumber, '') [OpportunityNumber] -- It is called Opportunity Number in BOSS
		,C.ContractNumber
		,C.CommitmentDate
		--ROW_NUMBER() over (partition by CTD.SalesContractId order by CTD.Id desc) RankNum
		
	FROM company.ContractTermDetail CTD (nolock)
	INNER JOIN company.ContractTermHeader CTH (nolock) ON CTH.Id = CTD.AccountContractHeaderId
	INNER JOIN enum.AccountContractType ACT (nolock) ON ACT.Id = CTD.ContractTypeId
	LEFT JOIN sales.Contract C (nolock) ON C.Id = CTD.SalesContractId
	INNER JOIN (
		SELECT SalesContractId
			,Max(Id) Id
			,Max(SalesforceContractId) SalesforceContractId
			,min(StartDate) StartDate
			,max(EndDate) EndDate
			,count(1) NumContracts
		FROM company.ContractTermDetail CTD2 (nolock)
				-- MW 09112020 check deleted
				where isDeleted = 0
		GROUP BY SalesContractId
		) CTDM ON CTDM.Id = CTD.Id
	) foo
WHERE --RankNum = 1 and 
	SalesContractId IS NOT NULL
