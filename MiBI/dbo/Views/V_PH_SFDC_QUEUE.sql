/*




 CREATE view [dbo].[V_PH_SFDC_QUEUE] as
 -- MW 08052015 Queue for PH - SFDC integration
 SELECT 
	a.ReqId,b.ShoretelId
	--b.ShoretelId as ST_ID     
	--,a.*
FROM         
CORPDB.STDW.dbo.LicenseRequest   a inner join
--CORPDB.STDW.dbo.V_LKM_CUST_LOOKUP b on a.MacAddress =b.MACAddress inner join
(
			select a.MACAddress, convert(varchar(15),c.SAP_CUSTOMER_ID) as ShoretelId ,
			c.CustomerID as LkmCustomerId, b.SystemID as LkmSystemId 
			from SVLOPSDB2.LicensesSQL.dbo.tblKeys a inner join
				 SVLOPSDB2.LicensesSQL.dbo.TblSystems b on a.SystemID = b.SystemID inner join
				 SVLOPSDB2.LicensesSQL.dbo.TblCustomers c on b.CustomerID = c.CustomerID 
			where a.KeyType = '7'		
			and a.IsDeprecated = 0
			--make sure its a number
			and isnumeric( c.ImpactNumber) = 1
) b on a.MacAddress =b.MACAddress inner join
CUSTOMERS c on b.ShoretelId = c.ImpactNumber collate database_default
WHERE 
a.Created >= convert(Char(10), '08-04-2016',101)
 and a.SfdcStatus = 'N' 
 
 UNION ALL
 -- LKM VAD MW 11032017
  SELECT 
	a.ReqId,b.ShoretelId
	--b.ShoretelId as ST_ID     
	--,a.*
FROM         
CORPDB.STDW.dbo.LicenseRequest   a inner join
--CORPDB.STDW.dbo.V_LKM_CUST_LOOKUP b on a.MacAddress =b.MACAddress inner join
(
			select a.MACAddress, convert(varchar(15),c.SAP_Customer_ID) as ShoretelId ,
			c.CustomerID as LkmCustomerId, b.SystemID as LkmSystemId 
			from SVLCORPLKMVAD.LicenseVAD.dbo.tblKeys a inner join
				 SVLCORPLKMVAD.LicenseVAD.dbo.TblSystems b on a.SystemID = b.SystemID inner join
				 SVLCORPLKMVAD.LicenseVAD.dbo.TblCustomers c on b.CustomerID = c.CustomerID 
			where a.KeyType = '7'		
			and a.IsDeprecated = 0
			--make sure its a number
			and isnumeric( c.ImpactNumber) = 1
) b on a.MacAddress =b.MACAddress inner join
CUSTOMERS c on b.ShoretelId = c.ImpactNumber collate database_default
WHERE 
a.Created >= convert(Char(10), '07-01-2017',101)
 and a.SfdcStatus = 'N'
 */
