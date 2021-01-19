
  CREATE View MWSandbox.VwSites as 
-- MW 11212017 Location Info for Santana
 select 
 AccountId, 
 COUNT(*) as Sites
 from [$(FinanceBI)].company.VwLocation
 where [Loc NumProfiles] >2
 group by AccountId