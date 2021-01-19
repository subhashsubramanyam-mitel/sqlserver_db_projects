 CREATE View [MWSandbox].[Vw4Or5Digit] as 
-- MW 11212017 4 or 5 digit ext Info for Santana
select AccountId, Count(*) as Profiles
from financeBI.provision.VwProfile
where len(Extension) Not IN ( 4,5) and isActive=1 and ProfileTypeId in   ( 5,  2,4)
group by AccountId