


CREATE PROCEDURE [support].[GetRiskMap_Details]
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@acc_team varchar(20),
	@score_from Decimal(5,2),
	@score_to Decimal(5,2),
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
		if @acc_team = 'NULL'
		select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account_New] 
			where 
			CustomerType in ('CLOUD','Legacy Cloud')
			--and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam is NULL
			Group By AccountName having Avg(Score) >= @score_from and Avg(Score) < @score_to
			order By AVG(Score) desc
		else
			select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account_New] 
			where CustomerType in ('CLOUD','Legacy Cloud')
			--and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam = @acc_team
			Group By AccountName having Avg(Score) >= @score_from and Avg(Score) < @score_to
			order By AVG(Score) desc
	end
	if(@Cust_type not like 'ALL')
	begin
		if @acc_team = 'NULL'
		select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account_New] 
			where 
			CustomerType = @Cust_type
			--and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam is NULL
			Group By AccountName having Avg(Score) >= @score_from and Avg(Score) < @score_to
			order By AVG(Score) desc
		else
			select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account_New] 
			where 
			CustomerType = @Cust_type
			--and CaseOwnerRole in ( Select COR from @CORole )
			and AccountTeam = @acc_team
			Group By AccountName having Avg(Score) >= @score_from and Avg(Score) < @score_to
			order By AVG(Score) desc
	end
end
