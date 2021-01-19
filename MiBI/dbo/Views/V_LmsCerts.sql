
CREATE VIEW [dbo].[V_LmsCerts]
AS
--JO 06092017 for Absorb5
select
a.Id,
c.ImpactNumber,
c.EmailAddress as Email,
b.Vendor as CertCode,
t.CourseDesc,
a.DateCompleted as CompleteDate,
a.DateStarted as SubscriptionDate,
c.FirstName,
c.LastName,
c.EmployeeNumber,
a.Status

from SVLINTDB.INTDB.dbo.LmsEnrollments a LEFT OUTER JOIN
SVLINTDB.INTDB.dbo.LmsCourses b on a.CourseId=b.Id LEFT OUTER JOIN
SVLINTDB.INTDB.dbo.LmsUsers c on a.UserId=c.Id LEFT OUTER JOIN
SVLINTDB.INTDB.dbo.TrainingCourseMap t on b.Vendor=t.CourseCode --there are dups because of this
Where c.EmailAddress not like '%@shoretel.com'
and ISNUMERIC(c.ImpactNumber)=1
--and a.Status='3'  --Passed only





