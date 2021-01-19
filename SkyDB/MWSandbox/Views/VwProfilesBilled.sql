

CREATE view  [MWSandbox].[VwProfilesBilled] as
-- MW 01242018  billed profiles  Manage/Courtesy
-- MW 05202020  updated to count active seats
select AccountId, count(*) as BilledProfiles
FROM [$(FinanceBI)].oss.VwServiceProduct_EX SP (nolock)
LEFT JOIN [$(FinanceBI)].enum.VwProduct P (nolock)
	on P.[Prod Id] = SP.ProductId
where 
					P.[Prod Category] = 'Profiles'
				AND ProductId != 355
				AND ServiceStatusId = 1
				AND IsMRRZero = 'NonZero' 
GROUP BY  AccountId

--select
--a.TNAccountId as AccountId,
--count(*) as BilledProfiles
--from 
--[$(FinanceBI)].audit.mVwTnProfileService a (nolock) inner join
--[$(FinanceBI)].audit.mVwLatestService b  (nolock) on a.ServiceId = b.ServiceId
--where a.ProfileTypeId in (2,5) and b.MonthMRRLastInvoiced =  select  DATEADD(month, DATEDIFF(month, 0, getdate()), 0)
--group by 
--a.TNAccountId
