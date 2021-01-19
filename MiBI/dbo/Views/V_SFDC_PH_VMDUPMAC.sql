/*
Create view [dbo].[V_SFDC_PH_VMDUPMAC] as
-- MArk duplicate VMWARE MACS in SFDC so we dont call customers and accuse them of being out of compliance.
-- Once it has been marked in SFDC (using salesorder), SFDC PHONEHOME orch will mark SE_ID field to DupMac so it will fall off list.
-- MW 11042015
select ReqId from CORPDB.STDW.dbo.LicenseRequest where MacAddress in (
select MACAddress FROM (
(
select  MACAddress, count(*) as dup
from SVLOPSDB2.LicensesSQL.dbo.tblKeys
where  KeyType = '7'		
and  IsDeprecated = 0 and VMwareMAC = 1
Group By MACAddress
HAVING Count(*) >1
)   )a) and SfdcStatus = 'C' and isnull(SE_ID, 'x') != 'DupMac'
*/