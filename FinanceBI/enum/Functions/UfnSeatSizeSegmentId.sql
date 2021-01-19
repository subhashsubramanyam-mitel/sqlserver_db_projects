-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-04-16
-- Description: returns the id of the corresponding book to bill segment
-- change log 2018-04-26 realigned seat size segments to Mitel
-- =============================================
CREATE FUNCTION [enum].[UfnSeatSizeSegmentId]
(
    @NumProfiles Int 
)
RETURNS int
AS
BEGIN
	
	DECLARE @SegId int;

	SET @SegId =  -- TODO: remove hardcoding
		CASE
			WHEN @NumProfiles is null THEN null
			WHEN @NumProfiles = 0 THEN 8
			WHEN @NumProfiles <= 50 then 1
			WHEN @NumProfiles <= 250 then 2
			WHEN @NumProfiles <= 500 then 3
			WHEN @NumProfiles <= 2500 then 4
			ELSE 5
		END			
	RETURN @SegId;

END
