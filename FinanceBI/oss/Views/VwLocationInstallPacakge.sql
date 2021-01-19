Create view oss.VwLocationInstallPacakge as
Select L.AccountId, LocationId
	,case 
		when num = 1 and IsJumpStartActive+IsJumpStartOther > 0  then 'JumpStart' 
		when num = 1 and IsExpertStartActive+IsExpertStartOther> 0 then 'ExpertStart'
		when IsJumpStartActive+IsJumpStartOther+IsExpertStartActive+IsExpertStartOther = 0 then 'Void'
		when IsExpertStartActive>0 then 'ExpertStart' 
		when IsJumpStartActive>0 then 'JumpStart'
		when IsExpertStartOther>0 then 'ExpertStart'
		when IsJumpStartOther>0 then 'JumpStart'
		else 'Error'
		end InstallPackage,
		IsExpertStartActive, IsExpertStartVoid,IsExpertStartOther,
		IsJumpStartActive, IsJumpStartVoid, IsJumpStartOther
	from (

select LocationId, 
	count(1) num,
	SUM(case when productId = 219 and SP.ServiceStatusId =1 then 1 else 0 end) IsJumpStartActive,
	SUM(case when productId = 219 and SP.ServiceStatusId in (25,26) then 1 else 0 end) IsJumpStartVoid,
	SUM(case when productId = 219 and SP.ServiceStatusId not in (1, 25, 26) then 1 else 0 end) IsJumpStartOther,
	SUM(case when productId = 221 and SP.ServiceStatusId =1 then 1 else 0 end) IsExpertStartActive,
	SUM(case when productId = 221 and SP.ServiceStatusId in (25,26) then 1 else 0 end) IsExpertStartVoid,
	SUM(case when productId = 221 and SP.ServiceStatusId not in (1, 25, 26) then 1 else 0 end) IsExpertStartOther
from oss.ServiceProduct SP
where productid in (219, 221)
group by LocationId
) foo
inner join company.Location L on L.Id = foo.LocationId
inner join company.Account A on A.Id = L.AccountId