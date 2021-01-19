





CREATE view [sfdc].[VwCGCustomers_CSM] as
-- MW for export to CGBI 05072020  Cannot call the synonym via a db link
-- for CSM retention stats called in sfdc.VwCGCustomers_CSM in costguardBI
select 
	 OtherERPNumber as AccountNumber
	,Platform 
	,CSM
	,AccountTeam
	,row_number() over (partition by OtherERPNumber order by Created desc) rn
from
[$(MiBI)].dbo.CUSTOMERS
where isnumeric (OtherERPNumber) =1 and CSM is not NULL and Status = 'Active'
 
