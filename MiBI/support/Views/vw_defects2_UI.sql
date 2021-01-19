
CREATE view [support].[vw_defects2_UI] as
SELECT 
Cases.ID,
Cases.CaseOwner,
Cases.Status,
Cases.AccountName,
Cases.CaseReason,
Cases.SubReason,
Cases.CaseNumber,
Cases.Theater,
Cases.AtRisk,
Cases.Instance,
Cases.Escalated,
CaseDefect.DefectNumber,
CaseDefect.Name,
DefectManagement.Type,
DefectManagement.DefectStatus,
Cases.CaseOwnerRole,
Cases.CreatedDate,
Cases.ClosedDate,
DefectManagement.EngEngageNum,
DefectManagement.FoundVia,
DefectManagement.Area,
DefectManagement.SubArea
FROM            
				Cases (nolock) left join
				CaseDefect (nolock) on CaseDefect.CaseID = Cases.ID left join
                DefectManagement (nolock) ON CaseDefect.Defect = DefectManagement.ID
				where 
				Cases.CreatedDate>='2019-01-01'
