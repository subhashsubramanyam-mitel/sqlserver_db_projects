CREATE PROCEDURE [dbo].[SetLmsCerts] AS

truncate table LMS_CERTS;

set IDENTITY_INSERT LMS_CERTS ON;
insert into LMS_CERTS
(Id, ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName, NewCertFlg)
SELECT        Id, ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName, NewCertFlg
FROM            LMS_CERTS_ALL;
set IDENTITY_INSERT LMS_CERTS OFF;

-- Called from LMS Loader.  
insert into LMS_CERTS
(ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName)
select  ImpactNumber, Email, 'BR-030' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS
where CertCode='BR-002'
--and CompleteDate<'2017-10-1'
UNION ALL
--Three users only have BR-002e
select  ImpactNumber, Email, 'BR-030' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS
where CertCode='BR-002e'
and Email IN
(
'carla@datavox.net',
'jdugbere@aesltd.com',
'krystalm@select-tele.com'
)

insert into LMS_CERTS
(ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName)
select  ImpactNumber, Email, 'BR-031' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS
where CertCode='BR-002'
--and CompleteDate<'2017-10-1'
UNION ALL
--Three users only have BR-002e
select  ImpactNumber, Email, 'BR-031' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS
where CertCode='BR-002e'
and Email IN
(
'carla@datavox.net',
'jdugbere@aesltd.com',
'krystalm@select-tele.com'
)

delete from LMS_CERTS
Where CertCode IN ('BR-002','BR-002e')
--and CompleteDate<'2017-10-1'








