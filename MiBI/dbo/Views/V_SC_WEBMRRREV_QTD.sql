/*
CREATE VIEW [dbo].[V_SC_WEBMRRREV_QTD]
AS
 
select
		a.ImpactNumber,
		isnull (m1.MRRRevQ1,0) as MRRRevQ1,
		isnull (m2.MRRRevQ2,0) as MRRRevQ2,
		isnull (m3.MRRRevQ3,0) as MRRRevQ3,
		isnull (m4.MRRRevQ4,0) as MRRRevQ4

FROM
	CORPDB.STDW.dbo.PARTNER_INFO a LEFT OUTER JOIN
(
select ImpactNumber, SUM(EstimatedMRR) as MRRRevQ1
from dbo.V_SC_MRRBilling
Where CloseDate BETWEEN dateadd(qq, datediff(qq, 0, '10-1-2016'), 0) and dateadd(qq, datediff(qq, 0, '10-1-2016')+1, 0)
Group by ImpactNumber
) m1 on a.ImpactNumber=m1.ImpactNumber COLLATE DATABASE_DEFAULT  LEFT OUTER JOIN

(
select ImpactNumber, SUM(EstimatedMRR) as MRRRevQ2
from dbo.V_SC_MRRBilling
Where CloseDate BETWEEN dateadd(qq, datediff(qq, 0, '10-1-2016')+1, 0) and dateadd(qq, datediff(qq, 0, '10-1-2016')+2, 0)
Group by ImpactNumber
) m2 on a.ImpactNumber=m2.ImpactNumber COLLATE DATABASE_DEFAULT  LEFT OUTER JOIN

(
select ImpactNumber, SUM(EstimatedMRR) as MRRRevQ3
from dbo.V_SC_MRRBilling
Where CloseDate BETWEEN dateadd(qq, datediff(qq, 0, '10-1-2016')+2, 0) and dateadd(qq, datediff(qq, 0, '10-1-2016')+3, 0)
Group by ImpactNumber
) m3 on a.ImpactNumber=m3.ImpactNumber COLLATE DATABASE_DEFAULT  LEFT OUTER JOIN

(
select ImpactNumber, SUM(EstimatedMRR) as MRRRevQ4
from dbo.V_SC_MRRBilling
Where CloseDate BETWEEN dateadd(qq, datediff(qq, 0, '10-1-2016')+3, 0) and dateadd(qq, datediff(qq, 0, '10-1-2016')+4, 0)
Group by ImpactNumber
) m4 on a.ImpactNumber=m4.ImpactNumber COLLATE DATABASE_DEFAULT
*/


