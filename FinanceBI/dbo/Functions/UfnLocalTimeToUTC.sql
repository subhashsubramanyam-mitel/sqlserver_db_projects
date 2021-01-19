create FUNCTION UfnLocalTimeToUTC 
(
	@LocalTime datetime2
)
RETURNS datetime2
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result datetime2

	SELECT @Result= dbo.UfnToUtc(@LocalTime, 'America/New_York')

	-- Return the result of the function
	RETURN @Result

END
