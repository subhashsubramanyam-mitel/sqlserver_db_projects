
CREATE PROCEDURE [support].[get_CaseAge_IndivAcc] 
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Acc_Name Varchar(20)	
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), CreatedDate, 101),AVG(CaseAge)
	from [support].[vw_MICS_CaseAge]
	where 
	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and AccountName = @Acc_Name
	/*and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	--and CSAT is not null -- and CSAT <> 'NULL' */
	Group by Convert(varchar(10), CreatedDate, 101)
	order by Convert(varchar(10), CreatedDate, 101)

END
