

-- =============================================
-- JO 03042015 
-- ============================================= 

CREATE PROCEDURE   [dbo].[TruncTrainingActivity] AS

truncate table TrainingActivityTmp;

truncate table LMS_CERTS_RAW;

insert into LMS_CERTS_RAW
(Id, ImpactNumber, Email, CertCode, CourseDesc, CompleteDate, SubscriptionDate, FirstName, LastName, EmployeeNumber, Status)

SELECT        Id, ImpactNumber, Email, CertCode, CourseDesc, CompleteDate, SubscriptionDate, FirstName, LastName, EmployeeNumber, Status
FROM            V_LmsCerts


