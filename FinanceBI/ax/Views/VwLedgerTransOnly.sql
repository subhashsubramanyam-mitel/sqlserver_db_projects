create view ax.VwLedgerTransOnly
as select * from ax.[VwLedgerTrans] 
WHERE DIMENSION3_ = '999'
