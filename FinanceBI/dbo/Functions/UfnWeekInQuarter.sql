

-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2014-11-26
-- Description: Start of the week number in the quarter
--              first week could be partial, partial 14th week may be present
--              matches the definition sent by Yad
-- =============================================
CREATE FUNCTION [dbo].[UfnWeekInQuarter]
(
	@GivenDate date
)
RETURNS int
AS
BEGIN
	DECLARE @wk int  =  Datepart(ww,@GivenDate) - Datepart(ww, dbo.UfnFirstOfQuarter(@GivenDate)) + 1 

	RETURN     @wk  ;

END


