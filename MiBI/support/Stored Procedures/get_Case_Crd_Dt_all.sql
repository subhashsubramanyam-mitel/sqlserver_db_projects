



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_Case_Crd_Dt_all] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
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
		SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS CDT
			,COUNT(DISTINCT ID) AS CntD_ID
		FROM dbo.Cases(NOLOCK)
		WHERE CreatedDate > '2019-01-01'
			AND CreatedDate >= @crd_Dt_From
			AND CreatedDate <= @crd_Dt_To
			AND CustomerType IN ('CLOUD','Legacy Cloud')
			and CaseOwnerRole IN ( Select COR from @CORole )
		GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
		ORDER BY CDT

	ELSE 
		SELECT CONVERT(VARCHAR(10), CreatedDate, 101) AS CDT
			,COUNT(DISTINCT ID) AS CntD_ID
		FROM dbo.Cases(NOLOCK)
		WHERE CreatedDate > '2019-01-01'
			AND CreatedDate >= @crd_Dt_From
			AND CreatedDate <= @crd_Dt_To
			and CustomerType = @CustType
			and CaseOwnerRole IN ( Select COR from @CORole )
		GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)
		ORDER BY CDT


END
