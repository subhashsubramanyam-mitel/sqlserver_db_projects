-- =============================================
-- Author:		Yaniv Schahar
-- Create date: 2/7/11
-- Description:	
-- =============================================
create PROCEDURE oss.UspSyncNPS 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	PRINT convert(varchar,getdate(),14) + N': Begin syncing NPS';

	-- Bring only new dates (which means dates we don't have yet)
	-- That would be one day past the last one we have already.
	DECLARE @dateFrom date;
	SELECT @dateFrom = DATEADD(d, 1, MAX(DATE)) FROM oss.NPS;
	IF @dateFrom IS NULL  -- Can only happen for the very first time
		SET @dateFrom = '1/1/2010';
	DECLARE @dateTo date;
	SET @dateTo = GETDATE();	-- Use local date
	IF @dateTo < @dateFrom
	BEGIN	-- This means the next day we need is tomorrow... can't do that.
		PRINT convert(varchar,getdate(),14) + N': Finish syncing NPS - Same day sync, no changes';
		RETURN
	END
	
	INSERT oss.Nps
	select 
		d.Date, 
		coalesce(score.NPS, 0) as Referencability,
		a.AccountId,
        score.DateScored		
        --,npsid 
		--,n.rank
	from 
		enum.DateSequence d
		cross join (select distinct AccountId from M5DB.m5db.dbo.Nps with(nolock)) a
		left join
		(
			select 
				a1.rank,
				a1.AccountId,
				a1.date,
				a2.date as toDate,
				a1.npsid
			from (
				select 
					RANK() over (partition by accountid order by CAST(DateScored as DATE)) as rank,
					AccountId, CAST(DateScored as DATE) as date, max(id) as npsid from M5DB.m5db.dbo.Nps with(nolock)
					group by AccountId, CAST(DateScored as DATE)
			) a1
			left join (
				select 
					RANK() over (partition by accountid order by CAST(DateScored as DATE)) as rank,
					AccountId, CAST(DateScored as DATE) as date, max(id) as npsid from M5DB.m5db.dbo.Nps with(nolock)
					group by AccountId, CAST(DateScored as DATE)
			) a2
			on a1.rank = a2.rank - 1
			and a1.AccountId = a2.AccountId
		) n
		on 
		  a.AccountId = n.AccountId
		  AND (
				d.Date >= n.date and d.Date < n.toDate
				or ( n.date = n.toDate and d.Date = n.date )
				or ( n.toDate is null and d.Date >= n.date )
			)
		left join M5DB.m5db.dbo.Nps score with(nolock) on npsid = score.Id
		inner join company.Account ac with(nolock) on ac.Id = a.AccountId
	where 
		coalesce(score.NPS, 0) > 0
		and d.Date between @dateFrom and @dateTo
	order by 
		a.AccountId, 
		d.Date

	-- Write the number of inserted rows to the log table
	DECLARE @inserts int;
	SELECT @inserts = @@rowcount

	PRINT convert(varchar,getdate(),14) + N': End syncing NPS';

	RETURN @inserts

END
