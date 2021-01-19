
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the id of the corresponding Forecast book to bill segment
-- =============================================
CREATE FUNCTION [enum].[UfnFcstBookToBillSegmentId]
(
	 @BookToBill float
)
RETURNS int
AS
BEGIN
	
	DECLARE @SegId int;

	SET @SegId =  -- TODO: remove hardcoding
		 CASE WHEN @BookToBill <= 30 THEN 1
		      WHEN @BookToBill <= 40 THEN 2
		      WHEN @BookToBill <= 50 THEN 3
		      WHEN @BookToBill <= 60 THEN 4
		      WHEN @BookToBill <= 70 THEN 5
		      WHEN @BookToBill <= 80 THEN 6
		      WHEN @BookToBill <= 90 THEN 7
		      WHEN @BookToBill <= 100 THEN 8
		      WHEN @BookToBill <= 110 THEN 9
		      WHEN @BookToBill <= 120 THEN 10
		      WHEN @BookToBill <= 999999 THEN 11
		      ELSE  null
		      END;
			
	RETURN @SegId;

END

