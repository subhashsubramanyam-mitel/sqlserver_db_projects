CREATE view [Tableau].[VwPmByLocation] as 
-- for transition to support cases MW 10282019
 Select * from
 
	(
select    o.LocationId, 
coalesce( p.FirstName+ ' '+p.LastName, cb.FirstName+ ' '+cb.LastName)  as PMName, 
o.id as OrderId, coalesce(p.Id, cb.Id) as PMId
,row_number() over (partition by o.LocationId order by o.Id desc) rn
from
oss.[Order] o left outer join
people.Person p on CASE WHEN o.ProjectManagerId = 0 then null else o.ProjectManagerId END  = p.Id left outer join
people.Person cb on o.CreatedByPersonId = cb.Id
where    o.OrderTypeId = 0 and  o.LocationId is not null
	) pm where  rn= 1