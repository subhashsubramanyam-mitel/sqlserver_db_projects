

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_FCR] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Convert(varchar(10), CreatedDate, 101),COUNT(FCR)
	from [support].[vw_MICS_FCR]
	where 
	CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	and FCR IS NOT NULL
	--and FCR <> 'NULL'
	Group by Convert(varchar(10), CreatedDate, 101)
	order by Convert(varchar(10), CreatedDate, 101)




END
