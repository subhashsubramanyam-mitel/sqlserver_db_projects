


CREATE PROCEDURE [support].[get_FCR_all] 
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
		select Convert(varchar(10), CreatedDate, 101),COUNT(FCR)
		from [support].[vw_MICS_FCR]
		where 
		CreatedDate >= @crd_Dt_From 
		and CreatedDate <= @crd_Dt_To
		and CustomerType IN (
			'CLOUD',
			'Legacy Cloud'
		)
		and CaseOwnerRole IN ( Select COR from @CORole )
		and FCR is not null 
		--and FCR <> 'NULL'
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101);
	
	Else
		select Convert(varchar(10), CreatedDate, 101),COUNT(FCR)
		from [support].[vw_MICS_FCR]
		where 
		CreatedDate >= @crd_Dt_From 
		and CreatedDate <= @crd_Dt_To
		and CustomerType = @CustType
		and CaseOwnerRole IN ( Select COR from @CORole )
		and FCR is not null 
		--and FCR <> 'NULL'
		Group by Convert(varchar(10), CreatedDate, 101)
		order by Convert(varchar(10), CreatedDate, 101);
		
END
