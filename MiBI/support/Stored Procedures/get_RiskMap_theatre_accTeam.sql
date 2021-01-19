







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_RiskMap_theatre_accTeam] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Score_from varchar(20),
	@Score_to varchar(20),
	@acc_team varchar(15)
	--@Cust_type varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	select count(Distinct t.an), avg(t.scr) , s.Theatre from
		(select AccountName as an, avg(Score)  as scr
			from support.[vw_MICS_Active_Account]
			where 
			/*CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
			and*/ AccountTeam = @acc_team
			Group by AccountName 
			having avg(Score) > @Score_from and avg(Score) < @Score_to
		) as t
	join support.[vw_MICS_Active_Account] s 
	on  t.an = s.AccountName
	group by s.Theatre 

END
