

 CREATE view [dbo].[V_TAB_LKMKEYS] as
 -- MW 09062018 For Ben LKM reporting

 select  'LKM' as Source
		,a.*
        ,b.SystemName
		,c.KeyType
		,d.LicenseType
		,c.SKU
		,c.DateGenerated
		,c.UALs
		,b.SystemID

 from   
	SVLOPSDB2.LicensesSQL.dbo.tblCustomers a  INNER JOIN
    SVLOPSDB2.LicensesSQL.dbo.tblSystems b ON a.CustomerID = b.CustomerID INNER JOIN
	SVLOPSDB2.LicensesSQL.dbo.tblKeys c ON b.SystemID = c.SystemID   INNER JOIN
    SVLOPSDB2.LicensesSQL.dbo.tblKeyTypes d ON c.KeyType = d.KeyType
where c.ReasonCode = 13
UNION ALL
 select  'LKM-VAD' as Source
		,a.*
        ,b.SystemName
		,c.KeyType
		,d.LicenseType
		,c.SKU
		,c.DateGenerated
		,c.UALs
		,b.SystemID

 from   
	SVLCORPLKMVAD.LicenseVAD.dbo.tblCustomers a  INNER JOIN
	SVLCORPLKMVAD.LicenseVAD.dbo.tblSystems b ON a.CustomerID = b.CustomerID INNER JOIN
	SVLCORPLKMVAD.LicenseVAD.dbo.tblKeys c ON b.SystemID = c.SystemID   INNER JOIN
    SVLCORPLKMVAD.LicenseVAD.dbo.tblKeyTypes d ON c.KeyType = d.KeyType
where c.ReasonCode = 13
