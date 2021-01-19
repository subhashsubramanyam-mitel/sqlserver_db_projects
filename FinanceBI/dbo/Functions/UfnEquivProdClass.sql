-- =============================================
-- Author:		Tarak Goradia
-- Create date: Feb 24, 2016
-- Description:	Resolve differences in Product Class
-- =============================================
CREATE FUNCTION dbo.UfnEquivProdClass
(
	-- Add the parameters for the function here
	@ProdClassA int, @ProdClassB int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result int = 0;

	SET @result = CASE 
			WHEN @ProdClassA = @ProdClassB THEN 1
			WHEN @ProdClassA = 7 and @ProdClassB = 8 then 1 
			WHEN @ProdClassA = 8 and @ProdClassB = 7 then 1 
			WHEN @ProdClassA = 11 and @ProdClassB = 12 then 1 
			WHEN @ProdClassA = 12 and @ProdClassB = 11 then 1 
			WHEN @ProdClassA = 14 and @ProdClassB = 15 then 1 
			WHEN @ProdClassA = 15 and @ProdClassB = 14 then 1 
			WHEN @ProdClassA =21 and @ProdClassB = 22 then 1 
			WHEN @ProdClassA = 22 and @ProdClassB =21 then 1 
			ELSE 0
			END;

	-- Return the result of the function
	RETURN @result;

END
