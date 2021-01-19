







CREATE View [company].[VwLocationProvisioning2_Deprecated] as
select L.[Loc Id], SUM(case when IsInstalled =1 then 1 else 0 end) Num, 
SUM(SP.MonthlyCharge ) TotalMRR, 
SUM(case when IsInstalled = 1 then SP.MonthlyCharge else 0 end) InstalledMRR, 
coalesce(SUM(case when IsInstalled = 1 then 
	enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled)
		else 0 end),0) TotalBBDays,
coalesce(SUM(case when IsInstalled = 1 then 
			SP.NumLifeDays
			else 0 end),0) TotalLifeDays,
coalesce(SUM(case when IsInstalled = 1 then 
			enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled)
			else 0 end)/NULLIF(SUM(case when IsInstalled =1 then 1 else 0 end),0),0) AvgLocBB,
coalesce(SUM(case when IsInstalled = 1 then 
			SP.NumLifeDays
			else 0 end)/NULLIF(SUM(case when IsInstalled =1 then 1 else 0 end),0),0) AvgLocLifeDays,
coalesce(MAX(IsLNP),0) WithPort
from (
	select SP.*, 
		CASE When SP.BillingStage in ('Forecasted', 'Unscheduled') and SP.MonthlyCharge <> 0
				and O.OrderTypeId in (0, 9) 
				THEN 1 ELSE 0 END as IsInstalled,
		CASE WHEN SP.ServiceclassId = 148 THEN 1 else 0 end IsLNP
	from oss.VwServiceProduct2 SP
	left join oss.VwOrder O on O.OrderId = SP.OrderId 
	where  SP.ServiceStatusId not in (25) -- not void
) SP
right outer join  company.VwLocation  L on SP.LocationId = L.[Loc Id] 
group by L.[Loc Id]











