







CREATE View archive.[VwLocationProvisioning] as
select L.[Loc Id], count(1) Num, SUM(SP.MonthlyCharge) TotalMRR, 
coalesce(SUM(enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled)),0) TotalBBDays,
coalesce(SUM(SP.NumLifeDays),0) TotalLifeDays,
coalesce(SUM(enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled))/count(1),0) AvgLocBB,
coalesce(SUM(SP.NumLifeDays)/count(1),0) AvgLocLifeDays
from company.VwLocation  L
left join oss.VwServiceProduct2 SP on SP.LocationId = L.[Loc Id]
		and SP.BillingStage in ('Forecasted', 'Unscheduled')
	and SP.ServiceStatusId not in (25)  and SP.MonthlyCharge <> 0
left join oss.VwOrder O on O.OrderId = SP.OrderId 
where O.OrderTypeId in (0, 9)
group by L.[Loc Id]











