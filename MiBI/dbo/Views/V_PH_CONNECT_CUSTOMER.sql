/*


CREATE View [dbo].[V_PH_CONNECT_CUSTOMER] as 
--  MW 08052015 determine connect customer from Phone Home.
--  USED IN AX SYNC AND V_PH_CONNECT_AX_SYNC
-- 
select ST_ID, -- ProductVersion, 
'Yes' as ConnectCustomer --Substring(ProductVersion, 0,charindex('.', ProductVersion)) as ProductMajor  
FROM (
SELECT 
	b.ShoretelId as ST_ID,   
	 d.ProductVersion,
	row_number() over (partition by b.ShoretelId  order by a.ReqId desc) rn
FROM         
CORPDB.STDW.dbo.LicenseRequest   a inner join
--CORPDB.STDW.dbo.V_LKM_CUST_LOOKUP b on a.MacAddress =b.MACAddress inner join
LKM_MACTOCUST  b on a.MacAddress =b.MACAddress inner join
CUSTOMERS c on b.ShoretelId = c.ImpactNumber collate database_default  inner join
CORPDB.STDW.dbo.LicenseInstallHist d on a.ReqId = d.ReqId
 where a.Created
  >= convert(Char(10), '01-01-2015',101)
  ) a where rn =1
  and Substring(ProductVersion, 0,charindex('.', ProductVersion)) >20

*/


