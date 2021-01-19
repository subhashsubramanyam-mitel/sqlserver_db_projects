-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 7/8/11
-- Description: Round up to the start of the current  day
-- =============================================
create FUNCTION UfnTruncateDay
(
	@GivenDate datetime2
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultDate date;

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultDate = -- start of the day 
		DateAdd(day, DAY(@GivenDate)-1, 
			DateAdd(month, MONTH(@GivenDate)-1, 
				DateAdd(year, YEAR(@givendate)-1900, 0))); -- 1900 is the base year

	-- Return the result of the function
	RETURN @ResultDate;

END
