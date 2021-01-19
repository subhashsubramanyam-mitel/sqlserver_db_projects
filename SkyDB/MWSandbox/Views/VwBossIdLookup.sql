  Create View MWSandbox.VwBossIdLookup as
 -- MW 12052017 Id lookup
 select AccountId, CustomerNum, LichenAccountId, count(*) as Total from
 	  MWSandbox.BossIdMap
	  group by AccountId, CustomerNum, LichenAccountId