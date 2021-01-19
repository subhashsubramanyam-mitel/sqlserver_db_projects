 Create view MWSandBox.VwProfileTypes
 as
select TP.TnAccountId, m.AccountName,

	SUM(CASE WHEN P.ProfileTypeId = 2 THEN 1 ELSE 0 END) as IsManagedProfile,
	SUM(CASE WHEN P.ProfileTypeId = 3 THEN 1 ELSE 0 END) as IsAnalogProfile,
	SUM(CASE WHEN P.ProfileTypeId = 5 THEN 1 ELSE 0 END) as IsCourtesyProfile,
	SUM(CASE WHEN P.ProfileTypeId = 8 THEN 1 ELSE 0 END) as IsProgramProfile 
 
from [$(FinanceBI)].audit.mVwTnProfile TP
inner join [$(FinanceBI)].provision.Profile P on P.Id = TP.ProfileId Inner join
 MWSandBox.MigrationCustList m on TP.TnAccountId = m.AccountId
 Group by TP.TnAccountId, m.AccountName