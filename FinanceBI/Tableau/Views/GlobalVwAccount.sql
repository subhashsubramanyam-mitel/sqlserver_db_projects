Create view Tableau.GlobalVwAccount as
select 'AU' As Source, * from AU_FinanceBI.[company].[VwAccount]
UNION ALL
select 'EU' As Source, * from EU_FinanceBI.[company].[VwAccount]
