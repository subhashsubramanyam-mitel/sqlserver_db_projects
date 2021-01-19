--select * from [support].[vw_defects_2020]
CREATE VIEW [support].[vw_defects_2020]
AS
SELECT Cases.CaseOwner
	,Cases.Status
	,Cases.CustomerType
	,Cases.AccountName
	,Cases.AccountTeam
	,Cases.CaseReason
	,Cases.SubReason
	,Cases.CaseNumber
	,Cases.Theater
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
FROM dbo.Cases(NOLOCK)
LEFT JOIN dbo.CaseDefect(NOLOCK) ON CaseDefect.CaseID = Cases.ID
LEFT JOIN dbo.DefectManagement(NOLOCK) ON CaseDefect.Defect = DefectManagement.ID
WHERE Cases.CreatedDate >= '2020-01-01'
	AND CaseDefect.CreatedDate >= '2020-01-01'
	AND DefectManagement.CreatedDate >= '2020-01-01'
