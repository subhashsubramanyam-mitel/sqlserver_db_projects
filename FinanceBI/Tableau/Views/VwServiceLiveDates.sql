
Create View tableau.VwServiceLiveDates as
--For Evo to import into SFDC opps  MW 05042019
select a.Source, a.OpportunityId, 
a.ServiceLive 

from
(
select b.OpportunityId,  a.* from
(
select 'US' as Source, a.ContractNumber as OppId, min(b.ServiceLive) as ServiceLive
from
oss.VwOrder a inner join
(
SELECT 
OrderId,
min(DateSvcLiveActual) as ServiceLive
  FROM  [oss].[ServiceProduct]
where ServiceStatusId = 1 and MonthlyCharge >0 and DateSvcCreated >= '2018-10-01'
group by OrderId
) b on a.OrderId = b.OrderId
where a.ContractNumber is not null
group by a.ContractNumber

union all
select  'AU' as Source, a.ContractNumber as OppId, min(b.ServiceLive) as ServiceLive
from
AU_FinanceBI.oss.VwOrder a inner join
(
SELECT 
OrderId,
min(DateSvcLiveActual) as ServiceLive
  FROM  AU_FinanceBI.[oss].[ServiceProduct]
where ServiceStatusId = 1 and MonthlyCharge >0 and DateSvcCreated >= '2018-10-01'
group by OrderId
) b on a.OrderId = b.OrderId
where a.ContractNumber is not null
group by a.ContractNumber

union all
select  'EU' as Source, a.ContractNumber as OppId, min(b.ServiceLive) as ServiceLive
from
EU_FinanceBI.oss.VwOrder a inner join
(
SELECT 
OrderId,
min(DateSvcLiveActual) as ServiceLive
  FROM  EU_FinanceBI.[oss].[ServiceProduct]
where ServiceStatusId = 1 and MonthlyCharge >0 and DateSvcCreated >= '2018-10-01'
group by OrderId
) b on a.OrderId = b.OrderId
where a.ContractNumber is not null
group by a.ContractNumber
) a inner join sfdc.VwOpportunity b on a.OppId = b.OpportunityNumber collate database_default 
) a  

