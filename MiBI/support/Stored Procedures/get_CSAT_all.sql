






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_CSAT_all] 
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
		select Convert(varchar(10), CreatedDate, 101),Avg(CSAT)--,CaseNumber
		from [support].[vw_MICS_CSAT]
		where 
		CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and CustomerType in ('CLOUD','Legacy Cloud')
		and CaseOwnerRole IN ( Select COR from @CORole )
		--and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
		--and CSAT is not null -- and CSAT <> 'NULL'
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101);
	
	Else
		select Convert(varchar(10), CreatedDate, 101),Avg(CSAT)--,CaseNumber
		from [support].[vw_MICS_CSAT]
		where 
		CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and CustomerType = @CustType
		and CaseOwnerRole IN ( Select COR from @CORole )
		--and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
		--and CSAT is not null -- and CSAT <> 'NULL'
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101)

	



END
