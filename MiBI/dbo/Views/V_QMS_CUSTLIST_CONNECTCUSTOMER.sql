/*
CREATE  View [dbo].[V_QMS_CUSTLIST_CONNECTCUSTOMER] as
-- MW 08132015 get connect customers from PhoneHome
-- this view is copied to local table via stored proc called from QMS_Custlist orch
		 SELECT  
	b.ShoretelId as ST_ID,    
	'Yes' As ConnectCustomer
FROM         
 CORPDB.STDW.dbo.LicenseRequest   a inner join
 CORPDB.STDW.dbo.V_LKM_CUST_LOOKUP b on a.MacAddress =b.MACAddress  inner join
 CORPDB.STDW.dbo.LicenseInstallHist d on a.ReqId = d.ReqId
 where  Substring(ProductVersion, 0,charindex('.', ProductVersion)) >=21
 */
