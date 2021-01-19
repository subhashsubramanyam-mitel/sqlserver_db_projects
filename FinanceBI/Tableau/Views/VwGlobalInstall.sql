Create View Tableau.VwGlobalInstall as
-- Tabby view for Pipline/Install tracking MW 05292018
--US
SELECT  'US' as Instance, InvoiceMonth, [MRR Category], [MRR Delta], NRR  FROM [invoice].[MatVwIncrMRRNRR_EX_2_2017] WHERE [InvoiceMonth] >= '2017-01-01' and [InvoiceMonth] < '2018-01-01'
union all
SELECT  'US' as Instance, InvoiceMonth, [MRR Category], [MRR Delta], NRR   FROM [invoice].[MatVwIncrMRRNRR_EX_2_Current]  
union all 
SELECT  'US' as Instance, InvoiceMonth, [MRR Category], [MRR Delta], NRR   FROM [invoice].[MatVwIncrMRRNRR_EX_2_2018] 
union all
--EU
SELECT  'EU' as Instance, InvoiceMonth, [MRR Category], [MRR Delta], NRR   FROM  EU_FinanceBI.FinanceBI.invoice.MatVwIncrMRRNRR_EX  
union all
--AU
SELECT  'AU' as Instance, InvoiceMonth, [MRR Category], [MRR Delta], NRR   FROM  AU_FinanceBI.FinanceBI.invoice.MatVwIncrMRRNRR_EX  

