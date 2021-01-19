
/*View to fetch only FCR related info*/
CREATE view [support].[vw_MICS_FCR]  as
select
a.CaseNumber,
a.FCR,
a.CreatedDate,
a.CustomerType,
a.CaseOwnerRole,
a.AccountTeam,
a.AccountName,
a.Theater
from [dbo].[Cases]  a join dbo.CUSTOMERS c on a.AccountName = c.NAME
where c.Status='Active'

