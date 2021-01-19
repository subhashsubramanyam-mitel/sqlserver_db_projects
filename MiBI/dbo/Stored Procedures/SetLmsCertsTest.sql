
CREATE PROCEDURE [dbo].[SetLmsCertsTest] AS

-- Called from LMS Loader.  
insert into LMS_CERTS_TEST
(ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName)
select  ImpactNumber, Email, 'BR-030' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS_TEST
where CertCode='BR-002'
--and CompleteDate<'2017-10-1'
UNION ALL
--Three users only have BR-002e
select  ImpactNumber, Email, 'BR-030' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS_TEST
where CertCode='BR-002e'
and Email IN
(
'carla@datavox.net',
'jdugbere@aesltd.com',
'krystalm@select-tele.com'
)

insert into LMS_CERTS_TEST
(ImpactNumber, Email, CertCode, CompleteDate, FirstName, LastName)
select  ImpactNumber, Email, 'BR-031' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS_TEST
where CertCode='BR-002'
--and CompleteDate<'2017-10-1'
UNION ALL
--Three users only have BR-002e
select  ImpactNumber, Email, 'BR-031' as CertCode, CompleteDate, FirstName, LastName
from LMS_CERTS_TEST
where CertCode='BR-002e'
and Email IN
(
'carla@datavox.net',
'jdugbere@aesltd.com',
'krystalm@select-tele.com'
)

delete from LMS_CERTS_TEST
Where CertCode IN ('BR-002','BR-002e')
and CompleteDate<'2017-10-1'





