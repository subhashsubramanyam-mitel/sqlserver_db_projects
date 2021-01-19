/*
CREATE VIEW [dbo].[V_TrainingActivity] as

-- JO 030312015 Training Actity for SFDC
-- Union in order to utilize current Cert clean-up process

SELECT     t.ROWID, t.EmployeeNum, r.SfdcId as PartnerId, t.CompanyName, t.FirstName, t.LastName, t.Email, t.VendorName, t.StatusDesc, t.Completed, t.Audience, 
                      t.SubscriptionDate, t.SessionStartDate, cm.CourseType

FROM 
--CORPDB.STDW.dbo.LMS_CERTS l LEFT OUTER JOIN 
TrainingActivity t LEFT OUTER JOIN
RESELLER r on t.ImpactNumber=r.ImpactNumber  LEFT OUTER JOIN
--CONTACTS c on t.EmployeeNum=c.SfdcId  COLLATE DATABASE_DEFAULT LEFT OUTER JOIN
CORPDB.STDW.dbo.TrainingCourseMap cm on t.VendorName=cm.CourseCode COLLATE DATABASE_DEFAULT

WHERE --VendorName is not NULL
--AND l.CertCode !='blank'
--AND EmployeeNum !=''
--AND EmployeeNum NOT like '1-%'
cm.CourseType is not NULL
AND r.SfdcId is not NULL
AND r.Status='Active'
--AND c.Active='Active'
AND t.ImpactNumber !='10000'
--and l.Email='a.mandap@mec.ph'

--JO 12222015 No longer needed
/*
UNION ALL

SELECT     ROWID, EmployeeNum, r.SfdcId as PartnerId, CompanyName, FirstName, LastName, t.Email, VendorName, StatusDesc, Completed, Audience, 
                      SubscriptionDate, SessionStartDate,cm.CourseType

FROM TrainingActivity t LEFT OUTER JOIN
RESELLER r on t.ImpactNumber=r.ImpactNumber LEFT OUTER JOIN
CONTACTS c on t.EmployeeNum=c.SfdcId LEFT OUTER JOIN
CORPDB.STDW.dbo.TrainingCourseMap cm on t.VendorName=cm.CourseCode COLLATE DATABASE_DEFAULT

WHERE t.StatusDesc IN('Not Started','In Progress')
AND VendorName is not NULL
AND EmployeeNum !=''
AND EmployeeNum NOT like '1-%'
AND cm.CourseType is not NULL
AND r.SfdcId is not NULL
AND r.Status='Active'
AND c.Active='Active'
AND t.ImpactNumber !='10000'
--and t.Email='a.mandap@mec.ph'
*/

/*
SELECT     ROWID, EmployeeNum, r.SfdcId as PartnerId, CompanyName, FirstName, LastName, Email, VendorName, StatusDesc, Completed, Audience, 
                      SubscriptionDate, SessionStartDate,cm.CourseType

FROM TrainingActivity t LEFT OUTER JOIN
RESELLER r on t.ImpactNumber=r.ImpactNumber LEFT OUTER JOIN
CORPDB.STDW.dbo.TrainingCourseMap cm on t.VendorName=cm.CourseCode COLLATE DATABASE_DEFAULT

WHERE VendorName is not NULL
AND EmployeeNum !=''
AND EmployeeNum NOT like '1-%'
AND cm.CourseType is not NULL
AND r.SfdcId is not NULL

--AND StatusDesc='Completed'
--AND Completed is not NULL
*/
*/