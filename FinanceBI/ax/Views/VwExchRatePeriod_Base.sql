

CREATE View [ax].[VwExchRatePeriod_Base] as
select RO.CURRENCYCODE, RO.EXCHRATE, DateAdd(day, 0,RO.FROMDATE) DateFrom, 
Coalesce(DateAdd(day,0,RN.FROMDATE),'2100-01-01') DateTo, RO.RECID
from ax.VwExchRateOrdered RO
left join ax.VwExchRateOrdered RN on RN.CURRENCYCODE = RO.CURRENCYCODE and RN.RankNum = RO.RankNum - 1


