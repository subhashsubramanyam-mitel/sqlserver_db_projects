CREATE PROCEDURE [support].[CSM_Open_Cases]
@CSM nvarchar(50)
AS
BEGIN
	Select cases.CaseNumber,cases.Score,cases.AccountName,cases.CaseOwnerRole,cases.Priority,cases.Status,cases.CreatedDate,cases.AtRisk,cases.Reason,cases.AccountTeam,
	defects.DefectNumber,defectman.DefectStatus,defectman.Area,defectman.SubArea,cases.ClosedDate,
	CASE WHEN cases.ClosedDate = '' or cases.ClosedDate is NULL THEN DATEDIFF(day, cases.CreatedDate, GETDATE()) 
	ELSE DATEDIFF(day, cases.CreatedDate, cases.ClosedDate)
	END AS CaseAge
	FROM  support.vw_MICS_Sntmt as cases LEFT JOIN CaseDefect as defects
	ON cases.CaseId = defects.CaseID
	LEFT JOIN dbo.DefectManagement as defectman ON defects.Defect = defectman.ID
	WHERE cases.CSM = @CSM and cases.CustomerType in ('CLOUD') 
	--and cases.CreatedDate between DATEADD(month, -1, GETDATE()) AND GETDATE()
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA','MiCC Adv Support TAC','CC Services EMEA','T1 Services EMEA','Customer Success Manager','ACC - East Pending Cases','ACC - Global Pending Cases','T1 - East Pending Cases','T1 - Global Pending Cases')
	and cases.Status not in ('Closed','Void','Duplicate','Spam','Closed - Known Issue','Deferred/Denied','RFO Sent','Send RFO','Shipped')
END