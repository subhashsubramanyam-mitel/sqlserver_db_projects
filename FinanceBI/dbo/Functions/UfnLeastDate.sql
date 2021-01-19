-- =============================================
-- Author:		Tarak Goradia 
-- Create date: 2012-02-05
-- Description: Returns the Least date; if all null, return '2100-01-01'
--              TODO: see if it possible to accept varargs in Ufn
-- =============================================
create FUNCTION UfnLeastDate (
 @D1    DATETIME,
 @D2	DATETIME,
 @D3	DATETIME,
 @D4	DATETIME,
 @D5	DATETIME,
 @D6	DATETIME
 )
RETURNS DATETIME
AS
BEGIN
	DECLARE @RD DATETIME = '2100-01-01';
	IF (@D1 < @RD) SET @RD = @D1;
	IF (@D2 < @RD) SET @RD = @D2;
	IF (@D3 < @RD) SET @RD = @D3;
	IF (@D4 < @RD) SET @RD = @D4;
	IF (@D5 < @RD) SET @RD = @D5;
	IF (@D6 < @RD) SET @RD = @D6;
	
    RETURN @RD;
END
