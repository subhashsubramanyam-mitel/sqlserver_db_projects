-- =============================================
-- Author:		Tarak Goradia
-- Create date: Jan 29, 2013
-- Description:	Encapsulating a query in multi-statement table function 
-- =============================================
create FUNCTION usage.UfnTnMonthlySummary 
(	
	--@ServiceMonth  Date -- not used 
)
RETURNS 
@TU TABLE 
(
	-- Add the column definitions for the TABLE variable here
	AccountId int null,
	TN nvarchar(15),
	ServiceMonth date,
	TotalCalls int null,
	TotalMinutes money null,
	TotalCharge money null,
	InCalls int null,
	InMinutes money null,
	InCharge money null,
	OutCalls int null,
	OutMinutes money null,
	OutCharge money null,
	ServiceId int,
	InVolume nvarchar(12),
	OutVolume nvarchar(12),
	TotalVolume nvarchar(12),
	InUse bit
)
AS
BEGIN
Insert into @TU
select foo.*, 
	S.ServiceId,
	CASE 
		WHEN coalesce(InMinutes,0) = 0 then 'a 0'
		WHEN InMinutes < 5 then 'b 0-5' 
		WHEN InMinutes < 30 then 'c 5-30'
		WHEN InMinutes < 100 then 'd 30-100'
		WHEN InMinutes < 500 then 'e 100-500'
		WHEN InMinutes < 1500 then 'f 500-1500'
		WHEN InMinutes < 5000 then 'g 1500-5000'
		WHEN InMinutes < 20000 then 'h 5000-20000'
		ELSE 'i 20000+' 
	 END as InVolume,
	CASE 
		WHEN coalesce(OutMinutes,0) = 0 then 'a 0'
		WHEN OutMinutes < 5 then 'b 0-5' 
		WHEN OutMinutes < 30 then 'c 5-30'
		WHEN OutMinutes < 100 then 'd 30-100'
		WHEN OutMinutes < 500 then 'e 100-500'
		WHEN OutMinutes < 1500 then 'f 500-1500'
		WHEN OutMinutes < 5000 then 'g 1500-5000'
		WHEN OutMinutes < 20000 then 'h 5000-20000'
		ELSE 'i 20000+'	 END as OutVolume,
	 CASE 
		WHEN coalesce(TotalMinutes,0) = 0 then 'a 0'
		WHEN TotalMinutes < 5 then 'b 0-5' 
		WHEN TotalMinutes < 30 then 'c 5-30'
		WHEN TotalMinutes < 100 then 'd 30-100'
		WHEN TotalMinutes < 500 then 'e 100-500'
		WHEN TotalMinutes < 1500 then 'f 500-1500'
		WHEN TotalMinutes < 5000 then 'g 1500-5000'
		WHEN TotalMinutes < 20000 then 'h 5000-20000'
		ELSE 'i 20000+'	 END as TotalVolume,
	CASE 
		WHEN coalesce(TotalMinutes,0) = 0 then 0 else 1 
	END as InUse
	from (
select 
	AccountId, Tn, ServiceMonth,
	SUM(NumCalls) TotalCalls,
	SUM(Minutes) TotalMinutes,
	SUM(Charge) TotalCharge,
	cast (SUM(CASE WHEN CdrServiceTypeId =1 THEN NumCalls ELSE 0 END) as Int) InCalls,
	cast (SUM(CASE WHEN CdrServiceTypeId =1 THEN Minutes ELSE 0 END) as money) InMinutes,
	cast (SUM(CASE WHEN CdrServiceTypeId =1 THEN Charge ELSE 0 END) as money) InCharge,
	cast (SUM(CASE WHEN CdrServiceTypeId =2 THEN NumCalls ELSE 0 END) as Int) OutCalls,
	cast (SUM(CASE WHEN CdrServiceTypeId =2 THEN Minutes ELSE 0 END) as money) OutMinutes,
	cast (SUM(CASE WHEN CdrServiceTypeId =2 THEN Charge ELSE 0 END) as money) OutCharge
from usage.TnSummary 
group by AccountId, Tn, ServiceMonth
) foo
left join (
	select ServiceId, TN, 
		ROW_NUMBER() over (Partition By TN order by ServiceStatusId asc, DateSvcCreated desc) as RankNum 
	 from oss.VwLatestService 
	 where ServiceClassId in (7,8,11,12,14,15,21,22,23)
	 ) S on S.TN = Foo.TN  and S.RankNum = 1
left join audit.VwTnProfileLocal T on T.TN = foo.Tn
left join company.VwAccount A on A.[Ac Id] = foo.AccountId
where (foo.AccountId is null or A.[Ac Id] is not null)
	and T.TN is not null
	RETURN
END
