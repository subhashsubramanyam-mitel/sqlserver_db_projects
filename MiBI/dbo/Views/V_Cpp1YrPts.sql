/*
CREATE VIEW [dbo].[V_Cpp1YrPts]
AS

-- Partner Year MRR Rev for dashboard

SELECT     a.ImpactNumber,SUM(FLOOR(IsNULL(r.Rev1Yr,0)/500)+FLOOR(IsNULL(mr.MRRRev1Yr,0)/10)) as Cpp1YrPts
FROM       CORPDB.STDW.dbo.PARTNER_INFO a LEFT OUTER JOIN
			CORPDB.STDW.dbo.V_RevPrev3Qtrs r on a.ImpactNumber=r.ImpactNumber LEFT OUTER JOIN
			[$(MiBI)].dbo.V_MRRRevPrev3Qtrs mr on a.ImpactNumber=mr.ImpactNumber COLLATE DATABASE_DEFAULT
GROUP BY a.ImpactNumber
*/


