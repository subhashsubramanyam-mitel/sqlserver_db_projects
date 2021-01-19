-- =============================================
-- Author:		Yaniv Schahar
-- Create date: 4/19/2012
-- Description:	The quick way to get the date part
-- =============================================
create FUNCTION UfnGetDatePart 
(
	-- Add the parameters for the function here
	@dt datetime
)
RETURNS datetime
AS
BEGIN

	RETURN DATEADD(dd, 0, DATEDIFF(dd, 0, @dt));

END
