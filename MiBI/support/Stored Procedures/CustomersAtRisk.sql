
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[CustomersAtRisk]	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SET NOCOUNT ON;
	select AccountName, avg(Score)  as 'Sentiment',count(distinct CaseId) as 'Total Cases'
		from support.[vw_MICS_Active_Account_New]
		where 
		/*CreatedDate >= @crd_Dt_From and CreatedDate <= @crd_Dt_To
		and*/ CustomerType in ('CLOUD')
		--and CaseOwnerRole in ( Select COR from @CORole )
		
		Group by AccountName 
		having avg(Score) >= -1 and avg(Score) < -0.25
END
