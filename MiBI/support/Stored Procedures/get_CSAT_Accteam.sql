﻿





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_CSAT_Accteam] 
	-- Add the parameters for the stored procedure here
	@crd_Dt_From DateTime,
	@crd_Dt_To DateTime,
	@Acc_team Varchar(20)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Convert(varchar(10), SurveyResponseDate, 101),Avg(CSAT)--,CaseNumber
	from [support].[vw_MICS_CSAT]
	where 
	SurveyResponseDate >= @crd_Dt_From and SurveyResponseDate <= @crd_Dt_To
	and AccountTeam = @Acc_team
	and CustomerType in ('CLOUD','Legacy Cloud')
	and CaseOwnerRole in ('CV Support','T1 Services ANZ','CC Services USA','CC Services Manila','T1 Services India','T1 Services USA','T1 Services Canada','T2 Services USA','T2 Services Canada','MiCC Adv Support TAC')
	and CSAT is not null -- and CSAT <> 'NULL'
	Group by Convert(varchar(10), SurveyResponseDate, 101)
	order by Convert(varchar(10), SurveyResponseDate, 101)

END
