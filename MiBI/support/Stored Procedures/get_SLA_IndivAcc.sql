
CREATE PROCEDURE [support].[get_SLA_IndivAcc] 
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Acc_Name varchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	select Convert(varchar(10), CreatedDate, 101) AS Crd_date, AVG(SLA)
	from [support].[vw_MICS_SLA]
	where 
	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and AccountName = @Acc_Name
	/*AND CustomerType IN (
			'CLOUD',
			'Legacy Cloud'
		)
		AND CaseOwnerRole IN (
			'CV Support',
			'T1 Services ANZ',
			'Mgr Customer Success - ANZ',
			'Service Delivery - ANZ',
			'T1 Services India',
			'T1 Services USA',
			'T1 Services Canada',
			'T2 Services USA',
			'T2 Services Canada',
			'CC Services Manila',
			'CC Services USA'
		)*/ 
	Group by Convert(varchar(10), CreatedDate, 101)
	order by Convert(varchar(10), CreatedDate, 101) ASC

END
