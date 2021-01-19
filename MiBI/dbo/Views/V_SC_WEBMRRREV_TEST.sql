/*
CREATE VIEW [dbo].[V_SC_WEBMRRREV_TEST]
AS
 
select
		a.ImpactNumber,
		a.Name, 
		m.Month,
		isnull (m.MRRRev,0) as MonthlyMRRRev,
		CAST((isnull(m.MRRRev,0)/10) as DECIMAL (14,1)) as MRRPoints

FROM
	CORPDB.STDW.dbo.PARTNER_INFO a left outer join
(
--MRR
select ImpactNumber, SUM(EstimatedMRR) as MRRRev,CONVERT(char(15), datename(month, CloseDate ) + '-' + CONVERT(CHAR(4),YEAR(  CloseDate ) ), 101) as Month
from dbo.V_SC_MRRBilling
Where CloseDate between convert(char(10), '10-01-2016',101) and convert(char(10), '10-01-2018',101)
Group by ImpactNumber,  CONVERT(char(15), datename(month, CloseDate ) + '-' + CONVERT(CHAR(4),YEAR(  CloseDate ) ), 101), DATEADD(month, DATEDIFF(month, 0, CloseDate), 0)
) m on a.ImpactNumber=m.ImpactNumber COLLATE DATABASE_DEFAULT
*/




