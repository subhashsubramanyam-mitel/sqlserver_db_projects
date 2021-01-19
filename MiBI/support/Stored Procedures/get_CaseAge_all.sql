


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_CaseAge_all] 
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
		select Convert(varchar(10), CreatedDate, 101),AVG(CaseAge)
		from [support].[vw_MICS_CaseAge]
		where 
		CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and CustomerType in ('CLOUD','Legacy Cloud')
		and CaseOwnerRole IN ( Select COR from @CORole )		
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101);
	else
		select Convert(varchar(10), CreatedDate, 101),AVG(CaseAge)
		from [support].[vw_MICS_CaseAge]
		where 
		CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and CustomerType = @CustType
		and CaseOwnerRole IN ( Select COR from @CORole )		
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101);

END
