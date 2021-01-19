






CREATE view [Tableau].[VwTxToSupportCases2] as 
-- Transition to Support MW 09122019

with cte_training as  -- MW 09252020 evo provided training
(
select distinct AccountId , 'Yes' as Training
from oss.ServiceProduct where ProductId in
( 
39	,
118	,
165	,
166	,
221	,
228	,
229	,
230	,
232	,
414	,
415	,
416	,
417	,
418	,
437	,
438	,
439	,
440	,
602	,
604	,
605	,
609	,
610	,
611	,
626	,
627	,
628	
)
and DateSvcLiveActual is not null
)


select 
a.*
,l.name as LocationName
--,datediff(d, l.DateLiveForecast, a.CreatedDate )as diff
-- ,l.DateLiveForecast
,pm.PMName
,convert(int,pm.LocationId) as LocationId
,pm.OrderId
,pm.PMId
,s.PartnerName as PartnerName_Cloud
,s.PartnerName_Onsite
,s.BOSS_Support_Partner__c
,isnull(t.Training, 'No') as [Account Had Instructor Led Training?]
from
  [$(MiBI)].dbo.V_TRANSITION_CASES a inner join
	people.Person p on a.PersonId = p.Id inner join
	company.Location l on isnull(a.RelatedLocationId,p.LocationId) = l.Id left outer join
	company.AccountAttr ca on l.AccountId = ca.AccountId left outer join
	tableau.mVwSFDCCustInfo s on l.AccountId = s.AccountId and isnumeric(s.AccountId) = 1 left outer join
	(
select    o.LocationId, p.FirstName+ ' '+p.LastName as PMName, o.id as OrderId, p.Id as PMId
,row_number() over (partition by o.LocationId order by o.Id desc) rn
from
oss.[Order] o inner join
people.Person p on o.ProjectManagerId = p.Id
where o.ProjectManagerId is not null and o.LocationId is not null
	) pm on l.Id = pm.LocationId and pm.rn= 1
left outer join cte_training t on ca.AccountId = t.AccountId

where a.CreatedDate >= l.DateLiveForecast and 
l.DateLiveForecast >= '2019-07-01' and (
datediff(d, l.DateLiveForecast, a.CreatedDate ) <=  90--CASE WHEN a.AccountTeam in ('Gold', 'Platinum ') then 10 Else 5 END
)
and ca.IsMCSSEnabled = 0
UNION ALL
--different logic requested for MCSS MW 03192020
select 
a.*
,l.name as LocationName
--,datediff(d, l.DateLiveForecast, a.CreatedDate )as diff
-- ,l.DateLiveForecast
,pm.PMName
--,convert(int,pm.LocationId) as LocationId
,p.LocationId
,pm.OrderId
,pm.PMId
,ss.PartnerName as PartnerName_Cloud
,ss.PartnerName_Onsite
,ss.BOSS_Support_Partner__c
,isnull(t.Training, 'No') as [Account Had Instructor Led Training?]
from
  [$(MiBI)].dbo.V_TRANSITION_CASES a inner join
	people.Person p on a.PersonId = p.Id inner join
	company.Location l on isnull(a.RelatedLocationId,p.LocationId) = l.Id left outer join
	company.AccountAttr ca on l.AccountId = ca.AccountId inner join 
	sales.Contract s on l.AccountId = s.AccountId left outer join
	tableau.mVwSFDCCustInfo ss on l.AccountId = s.AccountId and isnumeric(s.AccountId) = 1 left outer join
	(
select    o.LocationId, p.FirstName+ ' '+p.LastName as PMName, o.id as OrderId, p.Id as PMId
,row_number() over (partition by o.LocationId order by o.Id desc) rn
from
oss.[Order] o inner join
people.Person p on o.ProjectManagerId = p.Id
where o.ProjectManagerId is not null and o.LocationId is not null and o.OrderTypeId = 2 -- add
	) pm on l.Id = pm.LocationId and pm.rn= 1
	
	left outer join cte_training t on ca.AccountId = t.AccountId

where a.CreatedDate >= s.CommitmentDate and 
--l.DateLiveForecast >= '2019-07-01' and 
(
datediff(d, s.CommitmentDate, a.CreatedDate ) <=  90--CASE WHEN a.AccountTeam in ('Gold', 'Platinum ') then 10 Else 5 END
)
and ca.IsMCSSEnabled = 1

