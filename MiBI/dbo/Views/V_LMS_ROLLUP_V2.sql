
CREATE VIEW [dbo].[V_LMS_ROLLUP_V2]
AS
--CPP2.0
--04112016 per Monica added course below to UCSE

select imp.Email, 
		imp.ImpactNumber,
	ISNULL(f.Certs, 0) AS BR008,
	ISNULL(g.Certs, 0) AS BR008c,  --09162015 per Monica
	ISNULL(bp.Certs, 0) AS CCSE000,
	ISNULL(bq.Certs, 0) AS CCSI000,
	ISNULL(br.Certs, 0) AS CCSP000,
	ISNULL(bs.Certs, 0) AS MSE000,
	ISNULL(bt.Certs, 0) AS MSI000,
	ISNULL(bu.Certs, 0) AS SESA000,
	ISNULL(bv.Certs, 0) AS SESO000,
	ISNULL(bw.Certs, 0) AS SSA000,
	ISNULL(bx.Certs, 0) AS SSCA000,
	ISNULL(bz.Certs, 0) AS SSCE000,
	ISNULL(ca.Certs, 0) AS SSO000,
	ISNULL(cb.Certs, 0) AS UCSE000,
	ISNULL(cc.Certs, 0) AS UCSI000,
	ISNULL(cd.Certs, 0) AS UCSP000,
	ISNULL(ce.Certs, 0) AS OS110,
	ISNULL(cf.Certs, 0) AS OS111,
	ISNULL(cg.Certs, 0) AS PSC000

FROM

( select Distinct Email,ImpactNumber from LMS_CERTS ) imp LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-008'
	Group by Email ) f on imp.Email=f.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-008c' OR CertCode = 'BR-008.01c'	--09162015 per Monica
	Group by Email) g on imp.Email=g.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CCSE-000'
	Group by Email) bp on imp.Email=bp.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CCSI-000'
	Group by Email) bq on imp.Email=bq.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CCSP-000'
	Group by Email) br on imp.Email=br.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SMSE-000' OR CertCode = 'SMSE-000.01'
	Group by Email) bs on imp.Email=bs.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SMSI-000'
	Group by Email) bt on imp.Email=bt.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SESA-000'
	Group by Email) bu on imp.Email=bu.Email LEFT OUTER JOIN
	(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SESO-000'
	Group by Email) bv on imp.Email=bv.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SSA-000'
	Group by Email) bw on imp.Email=bw.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SSCA-000'
	Group by Email) bx on imp.Email=bx.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SSCE-000'
	Group by Email) bz on imp.Email=bz.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'SSO-000'
	Group by Email) ca on imp.Email=ca.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode IN ('UCSE-000','UCAE-000')  --JO 04112016 per Monica
	Group by Email) cb on imp.Email=cb.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'UCSI-000'
	Group by Email) cc on imp.Email=cc.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'UCSP-000'
	Group by Email) cd on imp.Email=cd.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-110'
	Group by Email) ce on imp.Email=ce.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-111'
	Group by Email) cf on imp.Email=cf.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'PSC-000'
	Group by Email) cg  on imp.Email=cg.Email

	



