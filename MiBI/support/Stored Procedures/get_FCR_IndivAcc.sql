
CREATE PROCEDURE [support].[get_FCR_IndivAcc] 
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Acc_Name Varchar(200)
	
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), CreatedDate, 101),COUNT(FCR)--,CaseNumber
	from [support].[vw_MICS_FCR]
	where 
	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and AccountName = @Acc_Name
	--and CustomerType in ('CLOUD','Legacy Cloud')
	--and AccountTeam = @Acc_Team
	--and CaseOwnerRole in ('CV Support','T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA') 
	Group by Convert(varchar(10), CreatedDate, 101)
	order by Convert(varchar(10), CreatedDate, 101)




END
