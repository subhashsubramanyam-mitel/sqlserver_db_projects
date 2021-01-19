/*
CREATE  VIEW [dbo].[V_SC_NEW_CUSTemp]
AS

SELECT     a.ImpactNumber, a.InvDate, a.DRev AS Billings--,c.SfdcCreateDateUTC,dateadd(hh,-7,c.SfdcCreateDateUTC) as TEST
--, b.CustomerID, b.Customer_Name AS CustomerName, b.Country_iso AS Country
FROM         CORPDB.STDW.dbo.PartnerRev a LEFT OUTER JOIN
                      --dbo.POS_CUST b ON a.EndCust = b.CustomerID LEFT OUTER JOIN
					dbo.CUSTOMERS c on a.EndCust=c.ImpactNumber COLLATE DATABASE_DEFAULT
WHERE     --(a.Name LIKE 'GAP %') AND
a.InvDate between convert(char(10), '10-01-2013',101) and convert(char(10), '10-01-2015',101)
and a.InvDate<=dateadd(hh,-7,c.SfdcCreateDateUTC)
and c.Status='Active'
*/
