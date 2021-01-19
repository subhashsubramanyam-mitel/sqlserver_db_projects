


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[GetRiskMap_AccTeamTheatre_Details]
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@theatre varchar(20),
	@score_from Decimal(5,2),
	@score_to Decimal(5,2),
	@accTeam varchar(15)
	--['-1','-0.8'])
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select Distinct AccountName, AVG(Score) from support.[vw_MICS_Active_Account] 
		where 
		CreatedDate >= @crd_Dt_From --'01-01-2020' 
		and CreatedDate <= @crd_Dt_To --getDate()
		and CustomerType in ('CLOUD','Legacy Cloud')
		and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC') 
		and Theatre = @theatre
		and AccountTeam = @accTeam
		--and Score > @score_to --'-1' 
		--and Score < @score_from --'-0.8'
		Group By AccountName having Avg(Score) > @score_from and Avg(Score) < @score_to
		order By AVG(Score) desc
END
