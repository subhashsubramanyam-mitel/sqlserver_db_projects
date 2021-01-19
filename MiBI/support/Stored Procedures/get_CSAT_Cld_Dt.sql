


CREATE PROCEDURE [support].[get_CSAT_Cld_Dt] 
	@cld_Dt_From DateTime,
	@cld_Dt_To DateTime
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), ClosedDate, 101),avg(CSAT)
	from [support].[vw_MICS_CSAT]
	where 
	ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
	and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
	--and CSAT is not null -- and CSAT <> 'NULL'
	Group by Convert(varchar(10), ClosedDate, 101)
	order by Convert(varchar(10), ClosedDate, 101)

END
