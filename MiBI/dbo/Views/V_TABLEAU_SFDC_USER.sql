create view V_TABLEAU_SFDC_USER as 
--user/owner/pm view for taskfeed reporting. MW 10212019
select 
	 a.ID as Id
	,a.Name
	,a.Email
	,a.RoleName
	,a.BossPersonId
	,b.Name as Manager
from 
	Users a (nolock) left outer join
	Users b (nolock) on a.ManagerId = b.ID