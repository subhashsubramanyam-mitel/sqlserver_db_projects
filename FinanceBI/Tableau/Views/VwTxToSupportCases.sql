
CREATE view [Tableau].[VwTxToSupportCases] as 
--  NOT VALID  USE [VwTxToSupportCases2] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Transition to Support MW 09122019

select 
a.*
,l.name as LocationName
--,datediff(d, l.DateLiveForecast, a.CreatedDate )as diff
-- ,l.DateLiveForecast
,pm.PMName
,convert(int,pm.LocationId) as LocationId
,pm.OrderId
,pm.PMId
from
  [$(MiBI)].dbo.V_TRANSITION_CASES a inner join
	people.Person p on a.PersonId = p.Id inner join
	company.Location l on p.LocationId = l.Id left outer join
	(
select    o.LocationId, p.FirstName+ ' '+p.LastName as PMName, o.id as OrderId, p.Id as PMId
,row_number() over (partition by o.LocationId order by o.Id desc) rn
from
oss.[Order] o inner join
people.Person p on o.ProjectManagerId = p.Id
where o.ProjectManagerId is not null and o.LocationId is not null and o.OrderTypeId = 0 -- initial only
	) pm on l.Id = pm.LocationId and rn= 1
where a.CreatedDate >= l.DateLiveForecast and 
l.DateLiveForecast >= '2019-07-01' and (
datediff(d, l.DateLiveForecast, a.CreatedDate ) <=  90--CASE WHEN a.AccountTeam in ('Gold', 'Platinum ') then 10 Else 5 END
)
