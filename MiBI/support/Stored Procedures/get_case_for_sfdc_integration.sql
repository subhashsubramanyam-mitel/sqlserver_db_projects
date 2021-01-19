





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [support].[get_case_for_sfdc_integration] 
	-- Add the parameters for the stored procedure here
	@casenumber varchar (20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select * from [support].[vw_CaseAnalysis_SF] 
	where CaseNumber = @casenumber
	
END
