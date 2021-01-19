
CREATE VIEW [dbo].[V_LMS_ROLLUP_V2_BK10012017]
AS
--CPP2.0
--04112016 per Monica added course below to UCSE

select imp.Email, 
		imp.ImpactNumber,
	ISNULL(a.Certs, 0) AS BR001,
	ISNULL(b.Certs, 0) AS BR002,
	ISNULL(c.Certs, 0) AS BR002e,
	ISNULL(d.Certs, 0) AS BR004,
	ISNULL(e.Certs, 0) AS BR006,
	ISNULL(f.Certs, 0) AS BR008,
	ISNULL(g.Certs, 0) AS BR008c,  --09162015 per Monica
	ISNULL(h.Certs, 0) AS BR201,
	ISNULL(i.Certs, 0) AS CS100,
	ISNULL(j.Certs, 0) AS CS103,
	ISNULL(k.Certs, 0) AS CS109,
	ISNULL(l.Certs, 0) AS CS300,
	ISNULL(m.Certs, 0) AS CS400,
	ISNULL(n.Certs, 0) AS OS100,
	ISNULL(o.Certs, 0) AS OS102,
	ISNULL(p.Certs, 0) AS OS105,
	ISNULL(q.Certs, 0) AS OS107,
	ISNULL(r.Certs, 0) AS OS108,
	ISNULL(s.Certs, 0) AS OS300,
	ISNULL(t.Certs, 0) AS OS301,
	ISNULL(u.Certs, 0) AS OS305,
	ISNULL(v.Certs, 0) AS OS305c,
	ISNULL(w.Certs, 0) AS OT101,
	ISNULL(x.Certs, 0) AS OT102,
	ISNULL(y.Certs, 0) AS OT103,
	ISNULL(z.Certs, 0) AS OT104,
	ISNULL(aa.Certs, 0) AS OT105,
	ISNULL(ab.Certs, 0) AS OT106,
	ISNULL(ac.Certs, 0) AS OT107,
	ISNULL(ad.Certs, 0) AS OT107e,
	ISNULL(ae.Certs, 0) AS OT108,
	ISNULL(af.Certs, 0) AS OT109,
	ISNULL(ag.Certs, 0) AS OT110,
	ISNULL(ah.Certs, 0) AS OT111,
	ISNULL(ai.Certs, 0) AS OT201,
	ISNULL(aj.Certs, 0) AS OT202,
	ISNULL(ak.Certs, 0) AS OT203,
	ISNULL(al.Certs, 0) AS OT204,
	ISNULL(am.Certs, 0) AS OT205,
	ISNULL(an.Certs, 0) AS OT205e,
	ISNULL(ao.Certs, 0) AS OT206,
	ISNULL(ap.Certs, 0) AS OT207,
	ISNULL(aq.Certs, 0) AS OT208,
	ISNULL(ar.Certs, 0) AS OT209,
	ISNULL(au.Certs, 0) AS OT211,
	ISNULL(av.Certs, 0) AS OT212,
	ISNULL(aw.Certs, 0) AS OT213,
	ISNULL(ax.Certs, 0) AS OT216,
	ISNULL(ay.Certs, 0) AS OT217,
	ISNULL(az.Certs, 0) AS OT218,
	ISNULL(ba.Certs, 0) AS OT250,
	ISNULL(bb.Certs, 0) AS OT302,
	ISNULL(bc.Certs, 0) AS OT303,
	ISNULL(bd.Certs, 0) AS OT304,
	ISNULL(be.Certs, 0) AS OT306,
	ISNULL(bf.Certs, 0) AS OT307,
	ISNULL(bg.Certs, 0) AS OT308,
	ISNULL(bh.Certs, 0) AS OT309,
	ISNULL(bi.Certs, 0) AS OT310,
	ISNULL(bj.Certs, 0) AS OT311,
	ISNULL(bk.Certs, 0) AS OT312,
	ISNULL(bl.Certs, 0) AS OT313,
	ISNULL(bm.Certs, 0) AS OT314,
	ISNULL(bn.Certs, 0) AS OT401,
	ISNULL(bo.Certs, 0) AS OT402,
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
Where CertCode = 'BR-001'
	Group by Email ) a on imp.Email=a.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-002'
	Group by Email ) b on imp.Email=b.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-002e'
	Group by Email ) c on imp.Email=c.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-004'
	Group by Email ) d on imp.Email=d.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'BR-006'
	Group by Email ) e on imp.Email=e.Email LEFT OUTER JOIN
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
Where CertCode = 'BR-201'
	Group by Email) h on imp.Email=h.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CS-100'
	Group by Email) i on imp.Email=i.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CS-103'
	Group by Email) j on imp.Email=j.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CS-109'
	Group by Email) k on imp.Email=k.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CS-300'
	Group by Email) l on imp.Email=l.Email LEFT OUTER JOIN
	(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'CS-400'
	Group by Email) m on imp.Email=m.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-100'
	Group by Email) n on imp.Email=n.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-102'
	Group by Email) o on imp.Email=o.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-105'
	Group by Email) p on imp.Email=p.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-107'
	Group by Email) q on imp.Email=q.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-108'
	Group by Email) r on imp.Email=r.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-300'
	Group by Email) s on imp.Email=s.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-301'
	Group by Email) t on imp.Email=t.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-305'
	Group by Email) u on imp.Email=u.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OS-305c'
	Group by Email) v on imp.Email=v.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-101'
	Group by Email) w on imp.Email=w.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'OT-102' 
	Group by Email) x on imp.Email=x.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-103'
	Group by Email ) y on imp.Email=y.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-104'
	Group by Email ) z on imp.Email=z.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-105'
	Group by Email) aa on imp.Email=aa.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-106'
	Group by Email) ab on imp.Email=ab.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-107'
	Group by Email) ac  on imp.Email=ac.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-107e'
	Group by Email) ad on imp.Email=ad.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-108'
	Group by Email) ae on imp.Email=ae.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-109'
	Group by Email) af  on imp.Email=af.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-110'
	Group by Email) ag on imp.Email=ag.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-111'
	Group by Email) ah on imp.Email=ah.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-201'
	Group by Email) ai on imp.Email=ai.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-202'
	Group by Email) aj on imp.Email=aj.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-203'
	Group by Email) ak on imp.Email=ak.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-204'
	Group by Email) al on imp.Email=al.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-205'
	Group by Email) am on imp.Email=am.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-205e'
	Group by Email) an on imp.Email=an.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-206'
	Group by Email) ao on imp.Email=ao.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-207'
	Group by Email) ap on imp.Email=ap.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-208'
	Group by Email) aq on imp.Email=aq.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-209'
	Group by Email) ar on imp.Email=ar.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-211'
	Group by Email) au on imp.Email=au.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-212'
	Group by Email) av on imp.Email=av.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-213'
	Group by Email) aw on imp.Email=aw.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-216e'
	Group by Email) ax on imp.Email=ax.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-217'
	Group by Email) ay on imp.Email=ay.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode = 'OT-218' 
	Group by Email) az on imp.Email=az.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-250'
	Group by Email) ba on imp.Email=ba.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-302'
	Group by Email) bb on imp.Email=bb.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-303'
	Group by Email) bc on imp.Email=bc.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-304'
	Group by Email) bd on imp.Email=bd.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-306'
	Group by Email) be on imp.Email=be.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-307'
	Group by Email) bf on imp.Email=bf.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-308'
	Group by Email) bg on imp.Email=bg.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-309'
	Group by Email) bh on imp.Email=bh.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-310'
	Group by Email) bi on imp.Email=bi.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-311'
	Group by Email) bj on imp.Email=bj.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-312'
	Group by Email) bk on imp.Email=bk.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-313'
	Group by Email) bl on imp.Email=bl.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-314'
	Group by Email) bm on imp.Email=bm.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-401'
	Group by Email) bn on imp.Email=bn.Email LEFT OUTER JOIN
(
select Email, count(CertCode) as Certs
 from 
LMS_CERTS 
Where CertCode  = 'OT-402'
	Group by Email) bo on imp.Email=bo.Email LEFT OUTER JOIN
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

	




