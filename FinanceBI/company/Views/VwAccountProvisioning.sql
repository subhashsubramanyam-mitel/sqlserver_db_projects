






CREATE View [company].[VwAccountProvisioning] as
select A.[Ac Id], count(1) Num, SUM(SP.MonthlyCharge) TotalMRR, 
coalesce(SUM(enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled)),0) TotalBBDays,
coalesce(SUM(SP.NumLifeDays),0) TotalLifeDays,
coalesce(SUM(enum.UfnBookToBillDays(BillingStage, DateSvcCreated,DateBillingValidFrom,DateSvcLiveScheduled))/count(1),0) AvgAcBB,
coalesce(SUM(SP.NumLifeDays)/count(1),0) AvgAcLifeDays
from company.VwAccount2  A
left join oss.VwServiceProduct2 SP on SP.AccountId = A.[Ac Id]
	and SP.BillingStage in ('Forecasted', 'Unscheduled')
	and SP.ServiceStatusId not in (25) and SP.MonthlyCharge <> 0
	and SP.OrderTypeId in (0, 9)
left join oss.VwOrder O on O.OrderId = SP.OrderId 
group by A.[Ac Id]










