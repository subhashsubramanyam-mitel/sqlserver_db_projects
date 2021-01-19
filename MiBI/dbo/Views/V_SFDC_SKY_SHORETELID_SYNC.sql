
 

 CREATE View [dbo].[V_SFDC_SKY_SHORETELID_SYNC] as
 --MW 01152015 Sync Boss/Sky account level shoretel Id to SFDC account from Invoice Group
 -- Orch: SyncSkySfdcAccount:BOSS_SYNCS
 select 
 --a.NAME,
 a.M5DBAccountID,
-- a.ImpactNumber,
 b.ShoretelId
 from 
 CUSTOMERS a inner join
 V_SKY_ACCOUNT_IDS b on a.M5DBAccountID = b.M5dbAccountID
 where 
	Type = 'Customer (Installed)' and
	isnull(Status,'X') != 'Inactive' 
	and (a.ImpactNumber is null or len(a.ImpactNumber )<6)
	--4552



