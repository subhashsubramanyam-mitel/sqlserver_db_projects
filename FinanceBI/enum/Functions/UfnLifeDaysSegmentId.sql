
-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the id of the corresponding Life Dayssegment
-- =============================================
create FUNCTION [enum].[UfnLifeDaysSegmentId]
(
    @DateCreated date, 
	@RefDate date
)
RETURNS int
AS
BEGIN
	
	DECLARE  @LifeDays float;
	DECLARE @SegId int;
	SET @LifeDays =DATEDIFF(day, @DateCreated, @RefDate)
		
	SET @SegId =  -- TODO: remove hardcoding
		 CASE WHEN @LifeDays <= 30 THEN 1
		      WHEN @LifeDays <= 60 THEN 2
		      WHEN @LifeDays <= 90 THEN 3
			  WHEN @LifeDays <= 99999 THEN 4 
		      ELSE  null
		      END;
			
	RETURN @SegId;

END

