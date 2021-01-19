

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_SLA] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime
	--@Score_from varchar(20),
	--@Score_to varchar(20)
	--@Cust_type varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Convert(varchar(10), CreatedDate, 101) AS Crd_date, AVG(SLA)
	from [support].[vw_MICS_SLA]
	where 
	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	AND CustomerType IN (
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
		) 
	Group by Convert(varchar(10), CreatedDate, 101)
	order by Convert(varchar(10), CreatedDate, 101) ASC

END
