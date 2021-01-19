-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 7/8/11
-- Description: Start of the month containing the given date+1day
-- =============================================
create FUNCTION UfnFirstOfMonthAfterRoundUp
(
	@GivenDate datetime2
)
RETURNS datetime2
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultDate datetime2;

	-- Add the T-SQL statements to compute the return value here
	SELECT @GivenDate = dbo.UfnRoundUpDay(@GivenDate); -- see definition of UfnRoundUp
	SELECT @ResultDate = 
		DateAdd(day, 0, -- first day of the month
			DateAdd(month, MONTH(@GivenDate)-1, 
				DateAdd(year, YEAR(@givendate)-1900, 0))); -- 1900 is the base year

	-- Return the result of the function
	RETURN @ResultDate;

END
