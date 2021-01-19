


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[GetRiskMap_Theatre_Details]
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@theatre varchar(20),
	@score_from Decimal(5,2),
	@score_to Decimal(5,2),
	@Cust_type varchar(15)
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
	select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account] 
		where 
		CreatedDate >= @crd_Dt_From 
		and CreatedDate <= @crd_Dt_To 
		and CustomerType in ('CLOUD','Legacy Cloud')
		and CaseOwnerRole in ( Select COR from @CORole )
		and Theatre = @theatre		
		Group By AccountName having Avg(Score) > @score_from and Avg(Score) < @score_to
		order By AVG(Score) desc
	END
	else
	begin
		select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account] 
		where 
		CreatedDate >= @crd_Dt_From 
		and CreatedDate <= @crd_Dt_To 
		and CustomerType = @Cust_type
		and CaseOwnerRole in ( Select COR from @CORole )
		and Theatre = @theatre		
		Group By AccountName having Avg(Score) > @score_from and Avg(Score) < @score_to
		order By AVG(Score) desc
	end
END
