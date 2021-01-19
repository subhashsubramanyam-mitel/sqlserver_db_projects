
CREATE PROCEDURE [support].[get_SLA_all] 
	@crd_Dt_From DATETIME,
	@crd_Dt_To DATETIME,
	@Cust_type VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CORole TABLE(COR VARCHAR(30));
		INSERT INTO @CORole VALUES ('CV Support');
		INSERT INTO @CORole VALUES ('T1 Services ANZ');
		INSERT INTO @CORole VALUES ('CC Services USA');
		INSERT INTO @CORole VALUES ('CC Services Manila');
		INSERT INTO @CORole VALUES ('T1 Services India');
		INSERT INTO @CORole VALUES ('T1 Services USA');
		INSERT INTO @CORole VALUES ('T1 Services Canada');
		INSERT INTO @CORole VALUES ('T2 Services USA');
		INSERT INTO @CORole VALUES ('T2 Services Canada');
		INSERT INTO @CORole VALUES ('MiCC Adv Support TAC');

	IF (@Cust_type Like 'ALL' )
		SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS Crd_date, AVG(SLA)
		FROM [support].[vw_MICS_SLA]
		WHERE 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			AND CustomerType IN (
					'CLOUD',
					'Legacy Cloud'
				)
			and CaseOwnerRole IN ( Select COR from @CORole ) 
		GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
		ORDER BY CONVERT(VARCHAR(10), CreatedDate, 101) ASC
	ELSE
		SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS Crd_date, AVG(SLA)
		FROM [support].[vw_MICS_SLA]
		WHERE 
			CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and CustomerType = @Cust_type
			and CaseOwnerRole IN ( Select COR from @CORole ) 
		GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
		ORDER BY CONVERT(VARCHAR(10), CreatedDate, 101) ASC
END
