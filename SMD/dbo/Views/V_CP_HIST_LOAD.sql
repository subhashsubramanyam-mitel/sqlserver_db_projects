


 CREATE view [dbo].[V_CP_HIST_LOAD] as 
 --loads daily table MW 07192018
 select 
		  rtrim(a.InstanceName) +'_' +  convert(char(10),getdate(),112) as InstanceDayKey
		 --,Getdate() as ReportDate
		 ,(select max(DateRank)+1 from CP_HIST) as DateRank
		 ,a.InstanceName as Instance
		 ,null as ActiveProvisioningInstance -- ?
		 ,null as AvailableforProvisioning -- ?
		 ,null as [Count] -- ?
		 ,((b.[Max]-a.AnticipatedTotalSeats)/b.[Max]) as  CapacityStatus
		 ,case when  b.InstanceType = 'Sky' and (a.AnticipatedTotalSeats*b.PctSIP) < 5250 then null else
		 CASE WHEN (a.AnticipatedTotalSeats-b.[Max] )<0 then null ELSE
					(a.AnticipatedTotalSeats-b.[Max]) END end as OverMaxSIP  --?

		 ,CASE WHEN (a.AnticipatedTotalSeats-b.[Max] )<0 then null ELSE
					(a.AnticipatedTotalSeats-b.[Max]) END as OverMaxSCCP --?

		,case when (a.AnticipatedTotalSeats-b.[Max]) > 0 then null else case when b.InstanceType = 'Sky' then 5250 - round(a.AnticipatedTotalSeats*b.PctSIP,0)
			ELSE b.StopProvisioningLimit   - a.AnticipatedTotalSeats END END as  AvailableforNewInstallsSIP

		,CASE WHEN a.AnticipatedTotalSeats < b.StopProvisioningLimit then  b.StopProvisioningLimit- a.AnticipatedTotalSeats
			else null end  as  AvailableforNewInstallsSCCP
		,a.AnticipatedTotalSeats-c.OneWeekAgo as [1-WeekChange]
		,a.AnticipatedTotalSeats-c.OneMonthAgo as [4-WeekChange]
		,b.InstanceType
		 -- ?OriginalType
		,isnull(b.PctSIP,1) as PCT_SIP
		,a.Accounts as ActiveSeatsAccounts

		 --,a.ActiveSeats
		,isnull(round(a.ActiveSeats*b.PctSIP,0),a.ActiveSeats) as ActiveSeatsSIP
		,isnull(round(a.ActiveSeats*(1-b.PctSIP),0),0) as ActiveSeatsSCCP
		,a.PendingBuiltSeats as PendingSeats_Built
		,a.PendingNotBuiltSeats as PendingSeats_NotBuilt
		,a.AnticipatedTotalSeats as InstanceAnticipatedTotal
		,b.StopProvisioningLimit as StopProvisioning
		,b.[Max] as InstanceMax
		--InstanceComments
		,b.InstanceRegion
		,b.InstanceBuildSequence
from
	CP_InstanceSnapshot a inner join
	CP_InstanceRef b on a.InstanceName = b.InstanceName collate database_default left outer join
	V_CP_DELTAS c on a.InstanceName = c.InstanceName collate database_default


