





CREATE view [sfdc].[VwCGCustomers_ChurnCodes] as
 -- MW 10202020  to be included in jason's Costgaurd churn reporting. Referenced from CostguardBI
select 
	     CustomerNumber
		,[RootCausePrimary]
		,[RootCauseSecondary]
		,RelatedProduct
from
[$(MiBI)].dbo.V_FBO_ChurnCodes
where rn = 1
 
