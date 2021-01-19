
-- select * from [MWSandbox].[VwDeviceInfo] 
CREATE view [MWSandbox].[VwUserDeviceInfo] as
-- MW 12192017 user Devince Info
select
a.TN
,SUM(CASE WHEN Device like '%Grandstream%' THEN 1 else 0 END) as Grandstream
,SUM(CASE WHEN Device like '%Cisco/SPA%' THEN 1 else 0 END) as CiscoSPA
,SUM(CASE WHEN Device like '%Cisco%' THEN 1 else 0  END) as CiscoATA
,SUM(CASE WHEN Device like '%Polycom%' THEN 1 else 0  END) as PolycomSoundStation
,SUM(CASE WHEN Device like '%LinkSys/SPA%' THEN 1 else 0  END) as LinkSysSPA

,SUM(CASE WHEN Device like '%Grandstream%' THEN 0 
		  WHEN Device like '%Cisco/SPA%' THEN 0  
		  WHEN Device like '%Cisco%' THEN  0
		  WHEN Device like '%Polycom%' THEN 0
		  WHEN Device like '%LinkSys/SPA%' THEN 0 else 1  END) as Other
 
from MWSandbox.DeviceInfo a inner join
MWSandbox.VwBossIdLookup b on a.CustomerNum = b.CustomerNum
Group by a.TN 
