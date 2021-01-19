

-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 7/8/11
-- Description: Start of the month containing the given date
-- =============================================
CREATE FUNCTION dbo.[UfnFirstDayofFiscalYear]
(
	@GivenDate date
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultDate date;

	-- Add the T-SQL statements to compute the return value here
	SELECT @ResultDate = 
		 Convert(varchar(4), 
				CASE WHEN MONTH(@GivenDate) > 6 then  YEAR(@GivenDate) else YEAR (@GivenDate)-1 END, 4)
		 +'-07-01'

	-- Return the result of the function
	RETURN @ResultDate;

END


