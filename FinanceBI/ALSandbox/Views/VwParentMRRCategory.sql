CREATE VIEW ALSandbox.VwParentMRRCategory AS

SELECT DISTINCT [MRR Category]
	,CASE WHEN [MRR Category] LIKE 'Price%' THEN 'Price Change'
		  WHEN [MRR Category] LIKE 'Change%' THEN 'Price Change'
		  WHEN [MRR Category] LIKE 'Cancel%' THEN RIGHT([MRR Category], len([MRR Category])- 9)
		  WHEN [MRR Category] = 'Reinstated' THEN 'Add'
		  WHEN [MRR Category] IN ('Install', 'Add') THEN [MRR Category]
		  ELSE 'NoChange'
		  END As ParentMRRCategory
FROM FinanceBI.invoice.VwMatVwIncrMRRNRR_EX MRRD