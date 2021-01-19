-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the number of days from book to bill or book to scheduled live.
-- =============================================
create FUNCTION enum.UfnBookToBillDays
(
    @BillingStage nvarchar(50), 
	@DateCreated_Local date,
	@DateBillingStart_Local date,
	@DateLiveScheduled_Local date
)
RETURNS float
AS
BEGIN
	DECLARE  @result int;
	/* May 10 Replacing this logic with date based logic because stage is not reliable
	SET @result = 
			CASE 
				WHEN @BillingStage ='Billing' or @BillingStage= 'ToBeBilled' THEN
					DateDiff(day,@DateCreated_Local, @DateBillingStart_Local)
				WHEN @BillingStage = 'Forecasted' THEN
					DateDiff(day,@DateCreated_Local, @DateLiveScheduled_Local)
				ELSE
					null
			END;
			*/
	
	SET @result = 
			CASE 
				WHEN @DateBillingStart_Local is not null THEN
					Coalesce(DateDiff(day,@DateCreated_Local, @DateBillingStart_Local),0)
				WHEN @DateLiveScheduled_Local is not null THEN
					Coalesce(DateDiff(day,@DateCreated_Local, @DateLiveScheduled_Local),0)
				ELSE
					null
			END;
	SET @result =
			CASE WHEN @result = 0 THEN @result+1 ELSE @result END;
	RETURN @result;

END
