CREATE FUNCTION [dbo].[UfnUTCTimeToLocal] 
(
	@UtcTime datetime
)
RETURNS datetime
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result datetime
	IF (DATEDIFF(DD,@UtcTime,'2015-11-01') = 0) AND (DATEPART(HH,@UtcTime) BETWEEN 0 AND 8)
      BEGIN
            SELECT @UtcTime = DATEADD(HH,1,@UtcTime)
      END

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = dbo.UfnToTZ(@UtcTime, 'America/New_York')

	-- Return the result of the function
	RETURN @Result

END
