



CREATE view [Tableau].[VwMcssAttribs] as
-- MW 11062019  Attribs for MCSS reporting requirements
select 
		Attr.AccountId, 
		a.ActiveProfiles, 
		a.FirstProfileActiveDate, 
		b.ActiveProfilesDayBeforeCommitmentDate, 
		c.ProfilesActivatedOnCommitmentDate,
		d.TotalActivatedMRR,
		e.TotalContractMRR,
		f.TotalContractProfileQty 

from
company.AccountAttr attr left outer join
(
select a.AccountId,  count(*) as ActiveProfiles, min(DateSvcLiveActual) as FirstProfileActiveDate
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.VwProduct b (nolock) on a.ProductId = b.[Prod Id] inner join
company.AccountAttr c  (nolock) on a.AccountId = c.AccountId and c.IsMCSSEnabled = 1  
where b.[Prod Category] = 'Profiles' and a.ServiceStatusId = 1
and b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
group by a.AccountId
) a on Attr.AccountId = a.AccountId left outer join
(
select a.AccountId,  count(*) as ActiveProfilesDayBeforeCommitmentDate
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.VwProduct b (nolock) on a.ProductId = b.[Prod Id] and b.[Prod Category] = 'Profiles'  inner join
company.AccountAttr c  (nolock) on a.AccountId = c.AccountId and c.IsMCSSEnabled = 1 inner join
 sales.Contract s (nolock) on c.AccountId = s.AccountId
where   a.ServiceStatusId = 1 and a.DateSvcLiveActual < s.CommitmentDate
and b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
group by a.AccountId 
) b  on Attr.AccountId = b.AccountId left outer join
(
select a.AccountId,  count(*) as ProfilesActivatedOnCommitmentDate
from 
oss.VwServiceProduct_EX a (nolock) inner join
enum.VwProduct b (nolock) on a.ProductId = b.[Prod Id] and b.[Prod Category] = 'Profiles'  inner join
company.AccountAttr c  (nolock) on a.AccountId = c.AccountId and c.IsMCSSEnabled = 1 inner join
 sales.Contract s (nolock) on c.AccountId = s.AccountId
where   a.ServiceStatusId = 1 and a.DateSvcLiveActual = s.CommitmentDate
and b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
group by a.AccountId 
) c on Attr.AccountId = c.AccountId
left outer join
( -- total MRR
select a.AccountId,  SUM(a.MonthlyCharge) as TotalActivatedMRR
from 
oss.VwServiceProduct_EX a (nolock) inner join
company.AccountAttr c  (nolock) on a.AccountId = c.AccountId and c.IsMCSSEnabled = 1  
where a.ServiceStatusId = 1 and a.DateSvcVoided is null
group by a.AccountId
) d  on Attr.AccountId = d.AccountId
left outer join
(
select c.AccountId,   SUM(cl.MRR*cl.Quantity) as TotalContractMRR
from 
company.AccountAttr c  (nolock)  inner join
 sales.Contract s (nolock) on c.AccountId = s.AccountId inner join
 sales.ContractLineItem (nolock) cl on s.Id = cl.ContractId 
where c.IsMCSSEnabled = 1
group by c.AccountId 
) e  on Attr.AccountId = e.AccountId
left outer join

(
select c.AccountId,   SUM(cl.Quantity) as TotalContractProfileQty
from 
company.AccountAttr c  (nolock)  inner join
 sales.Contract s (nolock) on c.AccountId = s.AccountId inner join
 sales.ContractLineItem (nolock) cl on s.Id = cl.ContractId inner join
 enum.VwProduct b (nolock) on cl.ProductId = b.[Prod Id] and b.[Prod Category] = 'Profiles'  
where   c.IsMCSSEnabled = 1 and 
  b.[Prod Id] <> 355 -- dont count IP Phone user, per Kelly
group by c.AccountId 
) f  on Attr.AccountId = f.AccountId
where Attr.IsMCSSEnabled = 1
 
