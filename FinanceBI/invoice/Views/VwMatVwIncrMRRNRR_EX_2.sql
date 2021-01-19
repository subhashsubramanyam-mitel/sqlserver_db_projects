







CREATE view [invoice].[VwMatVwIncrMRRNRR_EX_2]
as 
--  

-- YEAR 2018 - 2020
SELECT  * FROM [invoice].[MatVwIncrMRRNRR_EX_2_2018]  --WHERE [InvoiceMonth] >= '2018-01-01' and [InvoiceMonth] < '2020-06-01'
UNION ALL
-- YEAR CURRENT (2019 and 2020]
SELECT  * FROM [invoice].[MatVwIncrMRRNRR_EX_2_Current]  WHERE [InvoiceMonth] >= '2019-01-01'


--	select * from invoice.MatVwIncrMRRNRR_EX_Current

--	union all

--	select * from invoice.MatVwIncrMRRNRR_EX_FY18

--	union all

--	select * from invoice.MatVwIncrMRRNRR_EX_FY17

--	union all

--	select * from invoice.MatVwIncrMRRNRR_EX_FY16



--GO


