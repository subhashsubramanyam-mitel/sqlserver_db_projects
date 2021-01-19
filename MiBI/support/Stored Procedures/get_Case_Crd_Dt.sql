


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_Case_Crd_Dt] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS CDT
		,COUNT(DISTINCT ID) AS CntD_ID
	FROM dbo.Cases(NOLOCK)
	WHERE CreatedDate > '2019-01-01'
		AND CreatedDate >= @crd_Dt_From
		AND CreatedDate <= @crd_Dt_To
		AND CustomerType IN (
				'CLOUD'
				,'Legacy Cloud'
				)
		AND CaseOwnerRole IN (
				'CV Support'
				,'T1 Services ANZ'
				,'Mgr Customer Success - ANZ'
				,'Service Delivery - ANZ'
				,'T1 Services India'
				,'T1 Services USA'
				,'T1 Services Canada'
				,'T2 Services USA'
				,'T2 Services Canada'
				,'CC Services Manila'
				,'CC Services USA'
				)
	GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
	ORDER BY CDT


END
