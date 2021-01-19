-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the id of the corresponding book to bill segment
-- =============================================
create FUNCTION enum.UfnBookToBillSegmentId
(
    @BillingStage nvarchar(50),
    @DateCreated_Local date, 
	@DateBillingStart_Local date,
	@DateLiveScheduled_Local date
)
RETURNS int
AS
BEGIN
	
	DECLARE  @BookToBill float;
	DECLARE @SegId int;
	SET @BookToBill =
		enum.UfnBookToBillDays(
				@BillingStage, 
				@DateCreated_Local,
				@DateBillingStart_Local,
				@DateLiveScheduled_Local
				);
	SET @SegId =  -- TODO: remove hardcoding
		 CASE WHEN @BookToBill <= 10 THEN 1
		      WHEN @BookToBill <= 30 THEN 2
		      WHEN @BookToBill <= 60 THEN 3
		      WHEN @BookToBill <= 90 THEN 4
		      WHEN @BookToBill <= 120 THEN 5
		      WHEN @BookToBill <= 999999 THEN 6
		      ELSE  null
		      END;
			
	RETURN @SegId;

END
