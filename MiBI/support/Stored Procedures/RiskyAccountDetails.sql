
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

Create PROCEDURE [support].[RiskyAccountDetails]	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SET NOCOUNT ON;

	select s.AccountName,s.AccountTeam,s.CustomerType,s.CaseNumber from 
	(select AccountName, avg(Score)  as 'Sentiment',count(distinct CaseId) as 'Total Cases'
			from support.[vw_MICS_Active_Account_New]
			where 
			CustomerType in ('CLOUD')
			Group by AccountName 
			having avg(Score) >= -1 and avg(Score) < -0.25) as t
			join support.[vw_MICS_Active_Account_New] s
			on t.AccountName = s.AccountName
			where s.CaseNumber is not NULL 
			--having avg(Score) is not Null
			order by s.AccountName
END
