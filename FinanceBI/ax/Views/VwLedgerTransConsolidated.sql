create view ax.VwLedgerTransConsolidated
as select * from ax.[VwLedgerTrans] 
WHERE DIMENSION3_ <> '999'
