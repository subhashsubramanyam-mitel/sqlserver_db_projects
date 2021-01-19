
-- =============================================
-- Author:		Tarak Goradia
-- Create date: Dec 13, 2017
-- Description:	Concatenate Region and ID to give global ID
-- =============================================
CREATE FUNCTION [dbo].UfnGlobalID
(
	-- Add the parameters for the function here
	@region varchar(10), @id bigint
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result Varchar(50);

	SET @result = concat(@region, '-', convert(varchar(32),@id));

	-- Return the result of the function
	RETURN @result;

END

