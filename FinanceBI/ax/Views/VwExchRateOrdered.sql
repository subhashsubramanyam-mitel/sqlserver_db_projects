
CREATE View  [ax].[VwExchRateOrdered] as
select *, 
ROW_NUMBER() over  (PARTITION by CURRENCYCODE order by FROMDATE desc) RankNum
from ax.ExchRates ER
where DATAAREAID = 'exc'
and FROMDATE <> '1900-01-01'

