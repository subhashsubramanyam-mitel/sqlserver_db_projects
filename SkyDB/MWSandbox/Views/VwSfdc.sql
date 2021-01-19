 CREATE View [MWSandbox].[VwSfdc] as 
-- MW 11212017 AtRisk Info for Santana
 -- At Risk
select 
a.M5DBAccountId as AccountId, 
a.SfdcId,
CASE WHEN isnull(a.AtRiskNow,0)  = 0 then 'NO' ELSE 'YES' End As AtRisk
,a.CustomerType
,b.NAME as PartnerName
,b.SfdcId as PartnerSfdcId
,b.M5DBAccountId as PartnerM5DBAccountId_SFDC
from [$(FinanceBI)].sfdc.Account2 a left outer join
[$(FinanceBI)].sfdc.Account2 b on a.PartnerOfRecordCloud = b.SfdcId
where Isnumeric( a.M5DBAccountId) = 1 -- is not null
and a.Type = 'Customer (Installed)'