
Create VIEW V_CUSTOMER_INDUSTRY as
-- For Industry class sync for Connect to FinanceBI MW 06032020
select
	 a.M5DBAccountID
	,b.*
from
	CUSTOMERS a (nolock) inner join
	HANA_SIC b (nolock) on  a.SicCode = b.SIC4 collate database_default
where ISNUMERIC(a.M5DBAccountID) = 1