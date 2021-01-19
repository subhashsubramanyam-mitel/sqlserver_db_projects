CREATE PROCEDURE [support].[get_Case_Cld_Dt_all] 
	@cld_Dt_From DateTime,
	@cld_Dt_To DateTime,
	@CustType Varchar(20)
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CORole TABLE(COR varchar(30));
	insert into @CORole Values ('CV Support');
	insert into @CORole Values ('T1 Services ANZ');
	insert into @CORole Values ('CC Services USA');
	insert into @CORole Values ('CC Services Manila');
	insert into @CORole Values ('T1 Services India');
	insert into @CORole Values ('T1 Services USA');
	insert into @CORole Values ('T1 Services Canada');
	insert into @CORole Values ('T2 Services USA');
	insert into @CORole Values ('T2 Services Canada');
	insert into @CORole Values ('MiCC Adv Support TAC');
	
	IF (@CustType Like 'ALL' )
		SELECT CONVERT(VARCHAR(10), ClosedDate, 101) AS CDT
			,COUNT(DISTINCT ID) AS CntD_ID
		FROM dbo.Cases(NOLOCK)
		WHERE CreatedDate > '2019-01-01'
			AND ClosedDate >= @cld_Dt_From
			AND ClosedDate <= @cld_Dt_To
			AND CustomerType IN (
					'CLOUD'
					,'Legacy Cloud'
					)
			and CaseOwnerRole IN ( Select COR from @CORole )

		GROUP BY CONVERT(VARCHAR(10), ClosedDate, 101)
		ORDER BY CDT
	else	
		SELECT CONVERT(VARCHAR(10), ClosedDate, 101) AS CDT
			,COUNT(DISTINCT ID) AS CntD_ID
		FROM dbo.Cases(NOLOCK)
		WHERE CreatedDate > '2019-01-01'
			AND ClosedDate >= @cld_Dt_From
			AND ClosedDate <= @cld_Dt_To
			AND CustomerType =@CustType
			and CaseOwnerRole IN ( Select COR from @CORole )

		GROUP BY CONVERT(VARCHAR(10), ClosedDate, 101)
		ORDER BY CDT;
END
