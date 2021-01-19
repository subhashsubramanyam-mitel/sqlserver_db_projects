Create view Tableau.GlobalVwServiceProduct_EX as
select 'AU' As Source, * from AU_FinanceBI.oss.VwServiceProduct_EX
UNION ALL
select 'EU' As Source, * from EU_FinanceBI.oss.VwServiceProduct_EX
