

-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 7/8/11
-- Description: Start of the month containing the given date
-- =============================================
Create FUNCTION [dbo].[UfnFirstDayofCalendarYear]
(
	@GivenDate date
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultDate date;

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultDate =  Convert(varchar(4), YEAR(@GivenDate), 4) +'-01-01';

	-- Return the result of the function
	RETURN @ResultDate;

END


