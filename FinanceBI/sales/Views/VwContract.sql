-- SELECT * FROM [sales].[VwContract]
CREATE VIEW [sales].[VwContract]
AS
-- MW 07092020 View to show term version
SELECT a.Id
	,a.ContractNumber
	,a.Name
	,a.ContractTypeId
	,a.ContractStatusId
	,a.AccountId
	,a.DateContractWon
	,a.ContractLength
	,a.ContractSpecialTerms
	,a.SalesPersonId
	,a.LichenQuoteId
	,a.DateCreatedOriginal
	,a.CreatedByPersonId
	,a.DateModifiedOriginal
	,a.ModifiedByPersonId
	,a.DateModified
	,a.DateCreated
	,a.ModifiedBy
	,a.ContractFileName
	,a.ContractFilePath
	,a.ProjectManagerId
	,a.ContractGoLive
	,a.ClientProgrammerId
	,a.DataEngineerId
	,a.BillingLocationId
	,a.AccountManagerId
	,a.ContractSignedPersonId
	,b.Name AS BusinessTermVersion
	,a.RenewAutomatically
	,a.InstallTermUOM
	,a.InstallTermQuantity
	,a.DownturnPercentage
	,a.ProfileAmount
	,a.SalesForceId
	,a.PlatformTypeId
	,a.DateSigned
	,a.CommitmentDate
FROM sales.Contract AS a
LEFT OUTER JOIN enum.ContractBusinessTermVersion AS b ON a.BusinessTermVersion = b.Id
