create view ax.VwLedgerTrans
as select LT.*, ER.Rate, 
CASE WHEN LT.AMOUNTCUR <> 0.0 THEN ER.Rate * LT.AMOUNTCUR ELSE LT.AMOUNTMST END
as [USD@PlanX] 
from ax.LedgerTrans LT
left join enum.AxLedgerAccount LA on LA.[GL AccountNum] = LT.ACCOUNTNUM 
left join ax.PlanExchRate ER on ER.CurrencyCode = LT.CURRENCYCODE
  and LT.TRANSDATE between ER.DateFrom and ER.DateTo
WHERE LT.TRANSDATE >= '2013-07-01'
and LA.[GL Account type] <> 'Balance' -- Only 'Profit and Loss'
--and DATAAREAID <> '000'
