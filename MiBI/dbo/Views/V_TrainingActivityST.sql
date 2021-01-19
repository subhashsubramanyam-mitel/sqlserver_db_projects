/*
CREATE VIEW [dbo].[V_TrainingActivityST] as

-- JO 10062015 Training Actity for ShoreTel using the SF User Id

SELECT     ROWID, EmployeeNum, r.SfdcId as PartnerId, CompanyName, FirstName, LastName, t.Email, VendorName, StatusDesc, Completed, Audience, 
                      SubscriptionDate, SessionStartDate,cm.CourseType

FROM TrainingActivity t LEFT OUTER JOIN
RESELLER r on t.ImpactNumber=r.ImpactNumber LEFT OUTER JOIN
CORPDB.STDW.dbo.TrainingCourseMap cm on t.VendorName=cm.CourseCode COLLATE DATABASE_DEFAULT

WHERE t.StatusDesc IN('Not Started','In Progress','Completed')
AND VendorName is not NULL
AND EmployeeNum !=''
AND EmployeeNum NOT like '1-%'
AND cm.CourseType is not NULL
AND r.SfdcId is not NULL
AND r.Status='Active'
AND t.ImpactNumber ='10000'		--just ShoreTel
*/
