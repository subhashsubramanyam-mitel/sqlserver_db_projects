-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2013-11-08
-- Description: guess daily billing run date -- give a large window
-- =============================================
CREATE FUNCTION [invoice].[UfnDailyBillingRunDate]
(
	@GivenDate datetime2
)
RETURNS datetime2
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultDate datetime2;

	-- date of the day TEN hours ago
	-- This makes it possible to run daily billing in the evening to 11 pm next day
	SELECT @ResultDate = dbo.UfnTruncateDay(DateAdd(hour,-23, @givenDate))
		

	-- Return the result of the function
	RETURN @ResultDate;
	--RETURN '2017-04-30';

END
