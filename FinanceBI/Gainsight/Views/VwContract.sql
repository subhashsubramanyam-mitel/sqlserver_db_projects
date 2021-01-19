
CREATE view Gainsight.VwContract as
select 
	 CD.AccountId [M5DB Account ID]
	,AM.SfdcId [SfdcAccountId]
	,CD.Id [Contract ID]
	,CD.StartDate [Start Date]
	,CD.EndDate [End Date]
	,CD.BusinessTermVersion [Version]
	,CD.MRR [Contract MRR]
	,CD.ProfileAmount [Contract Seats]
	,CD.ContractType [Contract Type]
	,CD.RenewAutomatically [Renewal Type]
	,CD.TermMonths [Term]
	,cast(CD.DateCreated as Date) [DateCreated]
	,CD.IsActive [IsActive]
	,CD.DownturnPercentage [DownturnPercentage]
	,CD.ProfileLimit [ProfileLImit]
	,CD.InstallEnforcementDate [InstallEnforcementDate]
	,CD.EarlyTerminationFee [EarlyTerminationFee]
from company.VwContractDetail CD
left join sfdc.VwAccountMap AM on AM.M5dbAccountId = CD.AccountId

-- select top 1000 * from Gainsight.VwContract