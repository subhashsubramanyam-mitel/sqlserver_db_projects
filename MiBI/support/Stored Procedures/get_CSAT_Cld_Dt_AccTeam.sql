﻿




CREATE PROCEDURE [support].[get_CSAT_Cld_Dt_AccTeam] 
	@cld_Dt_From DateTime,
	@cld_Dt_To DateTime,
	@Acc_Team varchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), ClosedDate, 101),avg(CSAT)
	from [support].[vw_MICS_CSAT]
	where 
	ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
	and AccountTeam = @Acc_Team
	/*and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	and CSAT is not null -- and CSAT <> 'NULL'*/
	Group by Convert(varchar(10), ClosedDate, 101)
	order by Convert(varchar(10), ClosedDate, 101)

END
