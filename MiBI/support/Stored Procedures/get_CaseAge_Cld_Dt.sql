 
CREATE PROCEDURE [support].[get_CaseAge_Cld_Dt] 
	@cld_Dt_From DateTime,
	@cld_Dt_To DateTime
	
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), ClosedDate, 101),AVG(CaseAge)*1.00
	from [support].[vw_MICS_CaseAge]
	where 
	ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
	and Status = 'Closed'
	and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	--and CSAT is not null -- and CSAT <> 'NULL'
	Group by Convert(varchar(10), ClosedDate, 101)
	order by Convert(varchar(10), ClosedDate, 101)

END
