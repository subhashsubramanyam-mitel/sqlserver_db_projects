-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the number of days from book to bill or book to scheduled live.
-- =============================================
create FUNCTION enum.UfnLifeDays
(
    @BillingStage nvarchar(50), 
	@DateCreated_Local date,
	@DateBillingStopped_Local date,
	@ServiceStatusId int
)
RETURNS float
AS
BEGIN
	DECLARE  @result int;
	
	SET @result =  Coalesce(DateDiff(day,@DateCreated_Local, getdate()),0);

	--SET @result =			CASE WHEN @result = 0 THEN @result+1 ELSE @result END;
	RETURN @result;

END
