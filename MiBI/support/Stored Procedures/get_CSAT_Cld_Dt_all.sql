



CREATE PROCEDURE [support].[get_CSAT_Cld_Dt_all] 
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
		select Convert(varchar(10), ClosedDate, 101),avg(CSAT)
		from [support].[vw_MICS_CSAT]
		where 
		ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
		and CustomerType in ('CLOUD','Legacy Cloud')
		and CaseOwnerRole IN ( Select COR from @CORole )

		--and CSAT is not null -- and CSAT <> 'NULL'
		Group by Convert(varchar(10), ClosedDate, 101)
		order by Convert(varchar(10), ClosedDate, 101);
	ELSE
		select Convert(varchar(10), ClosedDate, 101),avg(CSAT)
		from [support].[vw_MICS_CSAT]
		where 
		ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
		and CustomerType = @CustType
		and CaseOwnerRole IN ( Select COR from @CORole )
		--and CSAT is not null -- and CSAT <> 'NULL'
		Group by Convert(varchar(10), ClosedDate, 101)
		order by Convert(varchar(10), ClosedDate, 101);
END
