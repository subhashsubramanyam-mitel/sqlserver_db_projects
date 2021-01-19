

CREATE View [Tableau].[VwMasterOrderPM] as 
-- MW 08232019 Show PM of Master Order

select
	 OrderId	
	,Master_PMName	
	,Master_PMId
FROM 
(
	select
	 OrderId	
	,Master_PMName	
	,Master_PMId
	,row_number() over (partition by Orderid order by Master_PMId desc) rn
FROM 
(
--linked adds
select 
	  o.Id as OrderId
	 ,isnull((p.FirstName + ' ' + p.LastName), 'Unassigned') as Master_PMName
	 ,p.Id as Master_PMId
from 
oss.[Order] o inner join
enum.OrderType ot on o.OrderTypeId =  ot.Id inner join
oss.[Order] oo on o.LinkedOrderId = oo.Id     inner join
oss.[Order] ooo on oo.MasterOrderId = ooo.Id  left outer join
people.Person p on ooo.ProjectManagerId = p.Id
union all
select 
	  o.Id as OrderId
	 ,isnull((p.FirstName + ' ' + p.LastName), 'Unassigned') as Master_PMName
	 ,p.Id as Master_PMId
from 
oss.[Order] o inner join
enum.OrderType ot on o.OrderTypeId =  ot.Id inner join
oss.[Order] ooo on o.MasterOrderId = ooo.Id     left outer join
people.Person p on ooo.ProjectManagerId = p.Id
) a 
) b where b.rn = 1

 

