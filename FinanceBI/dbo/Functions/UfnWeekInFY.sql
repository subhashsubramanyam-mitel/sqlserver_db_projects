


-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2015-09-02
-- Description: Start of the week number in the FY
--              first week could be partial, partial 14th week may be present
--              
-- =============================================
CREATE FUNCTION [dbo].[UfnWeekInFY]
(
	@GivenDate date
)
RETURNS int
AS
BEGIN
	DECLARE @wk int;
	
	Select @wk  = CASE WHEN MONTH(@GivenDate) > 6 then  
		Datepart(ww,@GivenDate) - Datepart(ww, dbo.UfnFirstDayOfFiscalYear(@GivenDate)) + 1 
	else (Datepart(ww,@GivenDate) - Datepart(ww, dbo.UfnFirstDayOfFiscalYear(@GivenDate)))
		+ Datepart(ww,  Convert(varchar(4), YEAR(@GivenDate)-1, 4) +'-12-31')
	END;

	RETURN     @wk  ;

END



