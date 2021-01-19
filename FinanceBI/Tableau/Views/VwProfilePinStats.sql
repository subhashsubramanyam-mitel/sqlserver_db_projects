

CREATE view [Tableau].[VwProfilePinStats] as
-- for Brandon tracking default pin setup mitigation MW 093020210
select
	 a.AccountId
	,c.CSM
	,c.AccountTeam
	,a.Profiles_Base
	,isnull(b.Profiles_Current,0) as Profiles_Current
from
tableau.mVwSFDCCustInfo c inner join
(
select AccountId, Count(*)  as Profiles_Base
from 
Tableau.ProfileSnapshot_base_1116
group by AccountId
) a on a.AccountId =c.AccountId and isnumeric(c.AccountId) = 1 left outer join
(
select AccountId , Count(*)  as Profiles_Current
from 
Tableau.ProfileSnapshot
where ReportDate = (select max(ReportDate) from Tableau.ProfileSnapshot)
group by AccountId
) b on a.AccountId = b.AccountId
