create view support.vw_defects_Erica as
SELECT 
Cases.CaseOwner,
Cases.Status,
Cases.Feature,
Cases.SubFeature,
Cases.AccountName,
Cases.CaseReason,
Cases.SubReason,
Cases.CustomerPlatform,
Cases.CustomerType,
Cases.CaseNumber,
Cases.Theater,
Cases.AtRisk,
CaseDefect.DefectNumber,
Cases.RelatedIncident,
Cases.Instance,
Cases.CaseOrigin,
CUSTOMERS.ActiveMRR_Boss,
CaseDefect.Name,
DefectManagement.Type,
DefectManagement.DefectStatus,
Cases.CaseOwnerRole,
Cases.CreatedDate,
DefectManagement.EngEngageNum,
DefectManagement.FoundVia,
DefectManagement.Area,
DefectManagement.SubArea
FROM            
				Cases (nolock) left join
				CUSTOMERS (nolock) on CUSTOMERS.SfdcId=Cases.AccountID left join
				CaseDefect (nolock) on CaseDefect.CaseID = Cases.ID left join
                DefectManagement (nolock) ON CaseDefect.Defect = DefectManagement.ID
				where 
				Cases.CreatedDate>='2019-10-01'