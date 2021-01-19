
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the id of the corresponding Avg Life Days segment
-- =============================================
Create FUNCTION [enum].[UfnAvgLifeDaysSegmentId]
(
    @LifeDays float
)
RETURNS int
AS
BEGIN
	
	DECLARE @SegId int;
		
	SET @SegId =  -- TODO: remove hardcoding
		 CASE WHEN @LifeDays <= 10 THEN 1
		      WHEN @LifeDays <= 20 THEN 2
		      WHEN @LifeDays <= 30 THEN 3
		      WHEN @LifeDays <= 60 THEN 4
		      WHEN @LifeDays <= 90 THEN 5
			  WHEN @LifeDays <= 99999 THEN 6
		      ELSE  null
		      END;
			
	RETURN @SegId;

END

