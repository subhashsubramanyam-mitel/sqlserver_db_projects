


-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2014-11-25
-- Description: Start of the week number in the quarter
--              first week could be partial, 13th week can be longer than 7 days; NO 14
-- =============================================
create FUNCTION [dbo].[UfnNSWeekInQuarter]
(
	@GivenDate date
)
RETURNS int
AS
BEGIN
	DECLARE @wk int  =  Datepart(ww,@GivenDate) - Datepart(ww, dbo.UfnFirstOfQuarter(@GivenDate)) + 1 

	RETURN    CASE WHEN @wk > 13 THEN 13 ELSE @wk END ;

END



