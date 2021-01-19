
CREATE PROCEDURE [support].[get_RiskMap_Acc_CI] 
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Score_from varchar(20),
	@Score_to varchar(20),
	@Cust_type varchar(30)
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

	if(@Cust_type like 'ALL')
	begin
		select count(Distinct t.an), avg(t.scr) , s.AccountTeam from
		(select AccountName as an, avg(CustomerScore)  as scr
		from support.[vw_MICS_Active_Account_CI]
		where 
		/*CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and*/ CustomerType in ('CLOUD','Legacy Cloud')
		--and CaseOwnerRole in ( Select COR from @CORole )
		and IsCustomer = 'Yes'
		Group by AccountName 
		having avg(CustomerScore) >= @Score_from and avg(CustomerScore) < @Score_to
		) as t
		join support.[vw_MICS_Active_Account_CI] s 
		on  t.an = s.AccountName
		group by s.AccountTeam 
	end
	else
	begin
		select count(Distinct t.an), avg(t.scr) , s.AccountTeam from
		(select AccountName as an, avg(CustomerScore)  as scr
		from support.[vw_MICS_Active_Account_CI]
		where 
		/*CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and */CustomerType = @Cust_type
		--and CaseOwnerRole in ( Select COR from @CORole )
		and IsCustomer = 'Yes'
		Group by AccountName 
		having avg(CustomerScore) >= @Score_from and avg(CustomerScore) < @Score_to
		) as t
		join support.[vw_MICS_Active_Account_CI] s 
		on  t.an = s.AccountName
		group by s.AccountTeam 
	end
	
	
	/*
	Select Count(AccountName),AVG(Score),AccountTeam 
	from support.vw_AccountSentiment
	where CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
	Group by AccountName,AccountTeam 
	having avg(Score) > @Score_from and avg(Score) < @Score_to
	*/
	

	---0.8 -0.5
END
