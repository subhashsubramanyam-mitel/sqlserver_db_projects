


 CREATE View [MWSandbox].[VwExtStartsWith09] as 
-- MW 11212017 0 or 9 digit ext Info for Santana
select a.AccountId, 
		Count(*) as Profiles,
	  SUM(CASE WHEN a.Extension like '0%' then 1 else 0 end) as ProfilesStartWith0,
	   SUM(CASE WHEN a.Extension like '9%' then 1 else 0 end) as ProfilesStartWith9
from [$(FinanceBI)].provision.VwProfile a inner join
[$(FinanceBI)].people.Person b on a.Tn = b.ProfileTN
where (a.Extension like '9%' OR a.Extension like '0%')  and a.isActive=1 and b.IsPerson =1 and b.IsActive =1 and 
a.ProfileTypeId in   ( 5,  2)
group by a.AccountId

