
--select * from [support].[vw_defects1]
CREATE VIEW [support].[vw_defects1]
AS
SELECT CUSTOMERS.CSM
	,CUSTOMERS.AtRiskNow
	,Cases.CaseOwner
	,Cases.Status
	,Cases.CaseOrigin
	,Cases.Feature
	,Cases.SubFeature
	,Cases.AccountName
	,Cases.AccountTeam
	,Cases.CaseReason
	,Cases.SubReason
	,Cases.CustomerPlatform
	,Cases.CustomerType
	,Cases.CaseNumber
	,Cases.Theater
	,Cases.AtRisk
	,Cases.Subject
	,Cases.Resolution
	,Cases.RootCause
	,CaseDefect.DefectNumber
	,CaseDefect.Name
	,DefectManagement.Type
	,DefectManagement.DefectStatus
	,Cases.CaseOwnerRole
	,Cases.CreatedDate
	,DefectManagement.EngEngageNum
	,DefectManagement.FoundVia
	,DefectManagement.Area
	,DefectManagement.SubArea
FROM dbo.CUSTOMERS(NOLOCK)
INNER JOIN dbo.Cases(NOLOCK) ON CUSTOMERS.SfdcId = Cases.AccountID
LEFT JOIN dbo.CaseDefect(NOLOCK) ON CaseDefect.CaseID = Cases.ID
LEFT JOIN dbo.DefectManagement(NOLOCK) ON CaseDefect.Defect = DefectManagement.ID
WHERE Cases.CreatedDate >= '2020-01-01'
	AND CaseDefect.CreatedDate >= '2020-01-01'
	AND DefectManagement.CreatedDate >= '2020-01-01'
