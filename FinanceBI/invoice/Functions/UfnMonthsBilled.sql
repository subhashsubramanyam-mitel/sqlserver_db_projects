-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2014-03-25
-- Description: the number of months (full and partial) within a period
-- CAUTION: this function RoundsUp both dates as in Lichen Billing Engine before
--          using them in computation
-- =============================================
create FUNCTION invoice.UfnMonthsBilled
(
	@DateBillingStart_Local date,
	@DateBillingStopped_Local date,
	@DateOfConsideration_Local date
)
RETURNS float
AS
BEGIN
	DECLARE @DateLastBilled_Local date;
	
	SET @DateLastBilled_Local = 
		CASE WHEN (@DateBillingStopped_Local is not null) 
					and @DateBillingStopped_Local < @DateOfConsideration_Local
			THEN @DateBillingStopped_Local
			ELSE @DateOfConsideration_Local
			END;
	RETURN invoice.UfnFractionalMonthsInPeriod(@DateBillingStart_Local, @DateLastBilled_Local);
END
