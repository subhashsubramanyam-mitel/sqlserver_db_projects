
CREATE View [Santana].[VwUserConfigDetail_delete] as
-- MW 05072020 User config detail for migrations
select 
a.AccountId,
c.Name as AccountName,
--a.ProfileTN,
a.FirstName,
a.LastName,
s.*
from
[$(FinanceBI)].people.VwPerson a inner join
[$(FinanceBI)].provision.VwProfile p on a.AccountId = p.AccountID and a.ProfileTN = p.Tn left outer join
[$(FinanceBI)].company.Account c on a.AccountId = c.Id left outer join
[$(FinanceBI)].company.Location b on p.LocationId = b.Id  
 inner join santana.VwTNConfigDetail s on a.ProfileTN = s.tn
UNION ALL
select 
p.AccountId,
c.Name as AccountName,
--a.ProfileTN,
p.Name  FirstName,
p.CallerId LastName,
s.*
from

[$(FinanceBI)].provision.VwProfile p   left join
[$(FinanceBI)].people.VwPerson a on p.AccountId =a.AccountID and a.ProfileTN = p.Tn left outer join
[$(FinanceBI)].company.Account c on p.AccountId = c.Id left outer join
[$(FinanceBI)].company.Location b on p.LocationId = b.Id  
 inner join santana.VwTNConfigDetail s on p.Tn = s.tn
where a.Id is null -- Only programming

GO
GRANT SELECT
    ON OBJECT::[Santana].[VwUserConfigDetail_delete] TO [SkyImp]
    AS [dbo];

