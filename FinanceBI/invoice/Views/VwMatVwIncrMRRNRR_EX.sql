




CREATE view [invoice].[VwMatVwIncrMRRNRR_EX]
as 
-- Current fiscal year + past two FY
	select * from invoice.MatVwIncrMRRNRR_EX_Current

	union all

	select * from invoice.MatVwIncrMRRNRR_EX_FY18

	union all

	select * from invoice.MatVwIncrMRRNRR_EX_FY17

	union all

	select * from invoice.MatVwIncrMRRNRR_EX_FY16



