create view enum.VwStateProvince as
select SP.*, C.CodeAlpha2 CountryCodeAlpha2
from enum.StateProvince SP
left join enum.Country C on C.Id = SP.CountryId