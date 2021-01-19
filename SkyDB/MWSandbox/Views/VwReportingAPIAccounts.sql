
Create View MWSandbox.VwReportingAPIAccounts as
-- MW 12122017 Shows accounts that use reporting api
select distinct b.AccountId 
from 
MWSandbox.ReportingAPIusers a inner join
[$(FinanceBI)].people.Person b on a.username = b.username
