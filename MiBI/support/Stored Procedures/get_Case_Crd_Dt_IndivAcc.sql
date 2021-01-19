 
CREATE PROCEDURE [support].[get_Case_Crd_Dt_IndivAcc] 
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Acc_Name Varchar(200)	
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS CDT
		,COUNT(DISTINCT ID) AS CntD_ID
	FROM dbo.Cases(NOLOCK)
	WHERE CreatedDate > '2019-01-01'
		AND CreatedDate >= @crd_Dt_From
		AND CreatedDate <= @crd_Dt_To
	and AccountName = @Acc_Name
	/*	AND CustomerType IN (
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
	*/
	GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
	ORDER BY CDT


END
