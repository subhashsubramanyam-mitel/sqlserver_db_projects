
 
CREATE PROCEDURE [support].[get_CaseAge_Cld_Dt_all] 
	@cld_Dt_From DateTime,
	@cld_Dt_To DateTime,
	@CustType varchar(20)
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
		select Convert(varchar(10), ClosedDate, 101),AVG(CaseAge)*1.00
			from [support].[vw_MICS_CaseAge]
			where 
			ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
			and Status = 'Closed'
			and CustomerType in ('CLOUD','Legacy Cloud')
			and CaseOwnerRole IN ( Select COR from @CORole )
			Group by Convert(varchar(10), ClosedDate, 101)
			order by Convert(varchar(10), ClosedDate, 101)
	else
		select Convert(varchar(10), ClosedDate, 101),AVG(CaseAge)*1.00
			from [support].[vw_MICS_CaseAge]
			where 
			ClosedDate >= @cld_Dt_From and ClosedDate <= @cld_Dt_To
			and Status = 'Closed'
			and CustomerType =@CustType
			and CaseOwnerRole IN ( Select COR from @CORole )
			Group by Convert(varchar(10), ClosedDate, 101)
			order by Convert(varchar(10), ClosedDate, 101)
END
