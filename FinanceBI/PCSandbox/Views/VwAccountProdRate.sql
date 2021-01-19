

CREATE view [PCSandbox].[VwAccountProdRate] as
select AR.AccountID, PPR.*
from PCSandbox.AccountRateTable AR
inner join PCSandbox.PlanProductRate PPR on PPR.PCPlanName = AR.PCPlanName and PPR.Region = AR.Region
where AR.PCPlanName is not null

