create view audit.VwTnProfileService as
select 
TP.*,
S.ServiceId, S.AccountId [SvcAccountId] 
from audit.VwTnProfileLocal TP
left join (
	select ServiceId, TN, AccountId,
		ROW_NUMBER() over (Partition By TN order by ServiceStatusId asc, DateSvcCreated desc) as RankNum 
	 from oss.VwLatestService 
	 where ServiceClassId in (7,8,11,12,14,15,21,22,23)
	 ) S on S.TN = TP.TN  and S.RankNum = 1
