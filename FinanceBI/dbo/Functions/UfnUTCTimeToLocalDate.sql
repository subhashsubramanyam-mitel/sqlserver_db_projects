CREATE FUNCTION [dbo].[UfnUTCTimeToLocalDate] 
(
	@UtcTime datetime2(4)
)
RETURNS Date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result date
	SET @UtcTime = CASE WHEN (@Utctime < '1970-01-01') THEN '1970-01-01' ELSE @UtcTime END;

	--Set @UtcTime = CASE WHEN datepart(hour, @UtcTime) < 23 and  datepart(day, @UTcTIme) = 1 -- first day anomaly
	--	THEN DateAdd(hour, 1, @UtcTime) ELSE @UtcTime END;

	IF (dbo.UfnTruncateDay(@UtcTime) = @UtcTime) 
		SELECT @Result = CAST( @UtcTime as Date)
    ELSE 
	-- Add the T-SQL statements to compute the return value here
		SELECT @Result = CAST (dbo.UfnUTCTimeToLocal(CAST(@UtcTime as DateTime)) as Date);

	-- Return the result of the function
	RETURN @Result

END

--select dbo.UfnUTCTimeToLocalDate('2011-11-01 04:00:00')
