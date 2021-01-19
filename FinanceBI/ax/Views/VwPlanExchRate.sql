
CREATE view [ax].[VwPlanExchRate] as 
select Id, CurrencyCode, DateFrom, DateTo, Rate ExchRate
from AX.PlanExchRate 
