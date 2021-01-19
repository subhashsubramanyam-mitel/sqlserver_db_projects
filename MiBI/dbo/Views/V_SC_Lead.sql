/*
CREATE VIEW [dbo].[V_SC_Lead]
AS

select
		a.ImpactNumber,
		l.RebateAmt,
		l.Qtr
FROM
	CORPDB.STDW.dbo.PARTNER_INFO a left outer join
(
-- New SC Revenue
select  PartnerSTID,   SUM(Rebate) as RebateAmt, CONVERT(char(15), datename(year, Date ) + '-' + CONVERT(CHAR(4),month(  Date ) ), 101) as Qtr
from LeadRebate where 
 Date between convert(char(10), '10-01-2015',101) and convert(char(10), '10-01-2017',101)
Group by PartnerSTID,  CONVERT(char(15), datename(year, Date ) + '-' + CONVERT(CHAR(4),month(  Date ) ), 101)--, DATEADD(month, DATEDIFF(month, 0, InvDate), 0)
) l on a.ImpactNumber = l.PartnerSTID COLLATE DATABASE_DEFAULT
*/