-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_CaseCategory] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Reason,SubReason,Feature,Count(Distinct CaseNumber)
	from [support].[vw_MICS_CaseCat]
	where CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('T1 Services ANZ','Mgr Customer Success - ANZ','Service Delivery - ANZ','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','CC Services Manila','CC Services USA')
	Group by Reason,SubReason,Feature

END
