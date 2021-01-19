-- ============================================================================================
-- Author:  Gerard Amitrano
-- Create date:   3/8/2013
-- Description:   Calculates the elapsed time (to the second) between the input values 
--                The elapsed time will be formatted as a string in the format HHHH:MM:SS
--                This function is expected to be called primarily by stored procedures that
--                insert into an Audit Log table
-- Return value:  The formatted elapsed time
-- ============================================================================================

create FUNCTION UfnCalcElapsed
(
  @pStartTime        datetime ,
  @pEndTime          datetime
)

RETURNS varchar(10)

 AS

  BEGIN

    -- Declare local variables
    DECLARE @TotalSecs   int;
    DECLARE @Hours       int;
    DECLARE @Minutes     int;
    DECLARE @Seconds     int;
    DECLARE @Elapsed     varchar(10);

    -- Initialize
    SET @Elapsed = '';

    -- Account for NULL or bad values
    IF ( @pEndTime IS NULL  OR  @pStartTime IS NULL  OR  @pStartTime > @pEndTime )
    BEGIN
        SET @Elapsed = '00:00:00';
    END

    ELSE

    BEGIN
        -- First, calculate the total elapsed time in seconds
        -- Then, use this amount to calculate hours, minutes, and seconds
        SET @TotalSecs = DATEDIFF(ss, @pStartTime, @pEndTime);
        SET @Hours = @TotalSecs / 3600;
        SET @Minutes = ( @TotalSecs - ( @Hours * 3600 ) ) / 60;
        SET @Seconds = ( @TotalSecs - ( @Hours * 3600 ) - ( @Minutes * 60 ) ) ;

        -- Now, format the values
        IF ( @Hours > 9999 )
        BEGIN
            -- We don't expect this to happen; just in case
            SET @Elapsed = '9999:59:59';
        END
        ELSE
        BEGIN
            -- Format the elapsed time        
            SET @Elapsed = CASE WHEN @Hours < 10 THEN '0' ELSE '' END
                         + CONVERT(varchar, @Hours)
                         + ':'
                         + REPLICATE('0', 2 - LEN(@Minutes))
                         + CONVERT(varchar, @Minutes)
                         + ':'
                         + REPLICATE('0', 2 - LEN(@Seconds))
                         + CONVERT(varchar, @Seconds); 
        END
    END

    -- Return the calculated, formatted value
    RETURN @Elapsed;

  END
